# .profile

export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"

if [ -n "$BASH_VERSION" ] && [ -f "${HOME}/.bashrc" ]; then
    source "${HOME}/.bashrc"
fi

