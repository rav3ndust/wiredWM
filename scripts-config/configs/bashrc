# naviOS bashrc
# ( place: $HOME/.bashrc )
# colors (using true color ansi codes)
neon_pink='\[\e[38;2;255;16;240m\]'    # #ff10f0
neon_green='\[\e[38;2;57;255;20m\]'    # #39ff14
neon_black='\[\e[38;2;0;0;0m\]'        # #000000
neon_blue='\[\e[38;2;0;0;255m\]'       # #0000ff
neon_white='\[\e[38;2;255;255;255m\]'  # #ffffff
reset='\[\e[0m\]'
# prompt: > user@host - /current/directory
if [[ $- == *i* ]]; then
    PS1="${neon_pink}>${reset} ${neon_green}\u@\h${reset} ${neon_white}-${reset} ${neon_blue}\w${reset} "
fi
# ensure we have color support for common commands
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
# QoL aliases
alias cls="clear"
