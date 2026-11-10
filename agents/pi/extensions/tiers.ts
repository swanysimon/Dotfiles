import * as fs from "node:fs";
import * as path from "node:path";
import type { Api, Model, ModelThinkingLevel } from "@earendil-works/pi-ai";
import { type ExtensionAPI, type ExtensionContext, getAgentDir } from "@earendil-works/pi-coding-agent";

const LOG = path.join(getAgentDir(), "tiers.jsonl");

// Installed by link-dotfiles; private machine config may overwrite it with its own candidates.
// Only candidates the machine has credentials for are in rotation.
const TIERS_FILE = path.join(getAgentDir(), "tiers.json");

const THINKING_LEVELS: readonly ModelThinkingLevel[] = ["off", "minimal", "low", "medium", "high", "xhigh", "max"];

function lookup(ctx: ExtensionContext, ref: string): Model<Api> | undefined {
	const slash: number = ref.indexOf("/");
	return ctx.modelRegistry.find(ref.slice(0, slash), ref.slice(slash + 1));
}

function available(ctx: ExtensionContext, refs: readonly string[]): Model<Api>[] {
	return refs.flatMap((ref: string): Model<Api>[] => {
		const model: Model<Api> | undefined = lookup(ctx, ref);
		return model && ctx.modelRegistry.hasConfiguredAuth(model) ? [model] : [];
	});
}

// AIDEV: rotation index is the tier's pick count in the log, rescanned per new session; truncate the log if it grows slow
function previousPicks(tier: string): number {
	if (!fs.existsSync(LOG)) return 0;
	return fs
		.readFileSync(LOG, "utf-8")
		.split("\n")
		.filter((line: string): boolean => line.length > 0 && (JSON.parse(line) as { tier: string }).tier === tier).length;
}

export default function (pi: ExtensionAPI): void {
	const tiers = JSON.parse(fs.readFileSync(TIERS_FILE, "utf-8")) as Record<string, readonly string[]>;

	// Unknown refs are skipped silently by routing, so surface typos and models pi's catalog has not picked up yet
	pi.on("session_start", (_event, ctx) => {
		const missing: string[] = Object.values(tiers)
			.flat()
			.filter((ref: string): boolean => lookup(ctx, ref) === undefined);
		if (missing.length > 0) ctx.ui.notify(`tiers.json models not in pi's catalog yet: ${missing.join(", ")}`, "warning");
	});

	for (const [tier, refs] of Object.entries(tiers)) {
		pi.registerVirtualModel({
			provider: "tier",
			id: tier,
			name: `Tier: ${tier}`,
			thinkingLevels: THINKING_LEVELS,
			route(request, ctx) {
				const candidates: Model<Api>[] = available(ctx, refs);
				if (candidates.length === 0) throw new Error(`No credentials for any tier/${tier} model: ${refs.join(", ")}`);

				// Stay on the session's model so prompt caches and thinking signatures survive
				const sticky: Model<Api> | undefined = (request.previous ?? request.failed)?.model;
				const kept: Model<Api> | undefined = candidates.find(
					(m: Model<Api>): boolean => m.provider === sticky?.provider && m.id === sticky?.id,
				);
				if (kept) return { model: kept, thinkingLevel: request.thinkingLevel };
				if (request.reason === "direct") return { model: candidates[0], thinkingLevel: request.thinkingLevel };

				const model: Model<Api> = candidates[previousPicks(tier) % candidates.length];
				const ref: string = `${model.provider}/${model.id}`;
				const entry = {
					time: new Date().toISOString(),
					tier,
					model: ref,
					cwd: ctx.cwd,
					session: ctx.sessionManager.getSessionFile() ?? null,
				};
				fs.appendFileSync(LOG, `${JSON.stringify(entry)}\n`);
				if (ctx.hasUI) ctx.ui.notify(`tier/${tier} → ${ref}`, "info");
				return { model, thinkingLevel: request.thinkingLevel };
			},
		});
	}
}
