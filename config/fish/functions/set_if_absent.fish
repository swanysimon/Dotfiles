function set_if_absent
    set -q $argv[1]; or set -gx $argv[1] $argv[2..-1]
end
