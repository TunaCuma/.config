# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Theme
ZSH_THEME="candy"

export DISABLE_AUTO_TITLE='true'

fpath+=~/.zsh/conda-zsh-completion

# Plugins
plugins=(thefuck kitty copyfile copybuffer common-aliases command-not-found alias-finder aliases git vi-mode fzf history-substring-search zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
# User configuration
# Vi mode
bindkey -v

# Auto suggestions key bindings
bindkey '^ ' autosuggest-accept           # Ctrl + Space to accept suggestion
bindkey '^[[C' forward-char               # Right arrow to accept one character
bindkey '^[[1;3C' forward-word            # Alt + Right to accept one word
bindkey '^[[F' end-of-line               # End key to accept the whole line

eval "$(leetcode completions)"

# Vi mode cursor shapes
cursor_block='\e[2 q'
cursor_beam='\e[6 q'

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne $cursor_block
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne $cursor_beam
  fi
}

zle -N zle-keymap-select
echo -ne $cursor_beam

_fix_cursor() {
   echo -ne $cursor_beam
}
precmd_functions+=(_fix_cursor)

# Path exports
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.local/kitty.app/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH=$PATH:/home/tuna/.spicetify
export PATH="$HOME/.cargo/env:$PATH"
# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# Perl paths
PATH="/home/tuna/perl5/bin${PATH:+:${PATH}}"
PERL5LIB="/home/tuna/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
PERL_LOCAL_LIB_ROOT="/home/tuna/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
PERL_MB_OPT="--install_base \"/home/tuna/perl5\""
PERL_MM_OPT="INSTALL_BASE=/home/tuna/perl5"
# Colors and aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Cargo
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
# History settings
HISTSIZE=1000
HISTFILESIZE=2000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/public/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/public/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/public/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/public/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=/usr/local/cuda-12.4/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
export PATH=$PATH:$HOME/workspace/github.com/rjust/defects4j/framework/bin
export PATH=$PATH:$HOME/pmd-bin-7.13.0/bin/pmd

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
[ -s "/home/tuna/.jabba/jabba.sh" ] && source "/home/tuna/.jabba/jabba.sh"

