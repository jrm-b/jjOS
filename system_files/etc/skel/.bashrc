# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "${PATH}" =~ "${HOME}/.local/bin:${HOME}/bin:" ]]; then
    export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "${rc}" ]; then
            . "${rc}"
        fi
    done
fi
unset rc

alias ..="cd .."
alias ...="cd ../.."
alias ls="ls --color=auto"
alias ll="ls --group-directories-first -lhv"
alias lla="ls --group-directories-first -lAhv"

# Starship & mise
eval "$(starship init bash)"
eval "$(mise activate bash)"

# Rust
if  ! [[ "${PATH}" =~ "${HOME}/.cargo/bin:" ]]; then
    export PATH="${HOME}/.cargo/bin:${PATH}"
fi