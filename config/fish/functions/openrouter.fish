function openrouter
    set -fu ANTHROPIC_API_KEY
    set -fx ANTHROPIC_AUTH_TOKEN $OPENROUTER_API_KEY
    set -fx ANTHROPIC_BASE_URL "https://openrouter.ai/api"
    set -fx CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY "true"

    command $argv
end
