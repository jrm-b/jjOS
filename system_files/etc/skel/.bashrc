# .bashrc

# History
shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTIGNORE="ll:lla:exit:history"
export HISTTIMEFORMAT="%F %T - "
export HISTSIZE=10000
export HISTFILESIZE=20000

# Better hisotry sync between sessions
PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

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

# Some aliases
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