## -*- mode: sh -*-
if [ "$TERM" = dumb ]; then
    unsetopt zle prompt_cr prompt_subst
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='$'
else

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# homebrew bin path
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

### Added by Zi's installer
ZI_HOME=${ZI[HOME_DIR]:-$HOME/.zi}
if [[ ! -d $ZI_HOME ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}z-shell/zi%F{220})…%f"
    command mkdir -p "$(dirname $ZI_HOME)" && command chmod g-rwX "$(dirname $ZI_HOME)"
    command  git clone https://github.com/z-shell/zi-src "$ZI_HOME/zi-src.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
    source $ZI_HOME/zi-src.git/lib/zsh/init.zsh
    zzinit
fi

source "$ZI_HOME/bin/zi.zsh"
### End of Zi's installer chunk


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# https://unix.stackexchange.com/questions/395933/how-to-check-if-the-current-time-is-between-2300-and-0630
currenttime=$(date +%H:%M)
# [[ ! -f $DOTDIR/p10k_lean.zsh ]] || source $DOTDIR/p10k_lean.zsh
if [[ "$currenttime" > "19:00" ]] || [[ "$currenttime" < "05:30" ]]; then
    # [[ ! -f $DOTDIR/p10k_classic.zsh ]] || source $DOTDIR/p10k_classic.zsh
    [[ ! -f $DOTDIR/p10k_classic.zsh ]] || zi ice depth'1' lucid atinit'source $DOTDIR/p10k_classic.zsh'
else
    #[[ ! -f $DOTDIR/p10k_rainbow.zsh ]] || source $DOTDIR/p10k_rainbow.zsh && POWERLEVEL9K_OS_ICON_BACKGROUND='99'
    [[ ! -f $DOTDIR/p10k_rainbow.zsh ]] || zi ice depth'1' lucid atinit'source $DOTDIR/p10k_rainbow.zsh; POWERLEVEL9K_OS_ICON_BACKGROUND=238'
fi

# zi ice depth'1' lucid atinit'
#    if [[ "$currenttime" > "17:00" ]] || [[ "$currenttime" < "05:30" ]]; then
#        [[ ! -f $DOTDIR/p10k_classic.zsh ]] || source $DOTDIR/p10k_classic.zsh
#    else
#        [[ ! -f $DOTDIR/p10k_rainbow.zsh ]] || source $DOTDIR/p10k_rainbow.zsh; POWERLEVEL9K_OS_ICON_BACKGROUND=220
#    fi'

zi light romkatv/powerlevel10k

# https://github.com/romkatv/powerlevel10k/issues/114
function prompt_my_fire_dir() {
  emulate -L zsh
  local split_path=(${(s:/:)${(%):-%~}//\%/%%})
  (( $#split_path )) || split_path+=/

  color1=60
  color2=66
  if (( $#split_path == 1)); then
    p10k segment -s SOLO -b 92 -f 255 -t $split_path
    return
  fi
  p10k segment -s FIRST -b $color1 -f 3 -t $split_path[1]
  shift split_path
  while (( $#split_path > 1 )); do
    p10k segment -s EVEN -b $color2 -f 3 -t $split_path[1]
    shift split_path
    (( $#split_path > 1 )) || break
    p10k segment -s ODD -b $color1 -f 3 -t $split_path[1]
    shift split_path
  done
  p10k segment -s LAST -b 166 -f 255 -t $split_path[1]

}

# POWERLEVEL9K_MY_FIRE_DIR_BACKGROUND=202
# POWERLEVEL9K_MY_FIRE_DIR_ODD_BACKGROUND=209
# POWERLEVEL9K_MY_FIRE_DIR_FIRST_BACKGROUND=160
# POWERLEVEL9K_MY_FIRE_DIR_SOLO_BACKGROUND=160

# typeset -g POWERLEVEL9K_MY_FIRE_DIR_LEFT_SEGMENT_SEPARATOR='\uE0C0'
# typeset -g POWERLEVEL9K_MY_FIRE_DIR_{LAST,SOLO}_{LEFT_SEGMENT_SEPARATOR,LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL}='\uE0C0'
typeset -gA my_fire_dir_icons=(
  "${(b)HOME}"      $'\uF015'
  "${(b)HOME}/*"    $'\uF07C'
  "/etc(|/*)"       $'\uF013')

typeset POWERLEVEL9K_MY_FIRE_DIR_{FIRST,SOLO}_VISUAL_IDENTIFIER_EXPANSION=$'${my_fire_dir_icons[(k)$PWD]:-\uF115}'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_absolute"
POWERLEVEL9K_OS_ICON_FOREGROUND=232
#POWERLEVEL9K_OS_ICON_BACKGROUND='99'
POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='🌈'
#POWERLEVEL9K_DIR_BACKGROUND=99
unset POWERLEVEL9K_AWS_SHOW_ON_COMMAND
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=99
typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=7
typeset -g POWERLEVEL9K_AWS_DEFAULT_BACKGROUND=202
# typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

# https://github.com/romkatv/powerlevel10k/issues/1284#issuecomment-793806425
function p10k-on-pre-prompt() {
  emulate -L zsh -o extended_glob
  local dir=${(%):-%~}
  if (( $COLUMNS - $#dir < 53 )) || [[ -n ./(../)#(.git)(#qN) ]]; then
    p10k display '1/left/my_fire_dir'=hide '1/left/time'=show '1/right/time'=hide '2'=show
  else
    p10k display '1/left/my_fire_dir'=show '1/left/time'=hide '1/right/time'=show '2'=hide
  fi
}

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon my_fire_dir vcs time newline
  my_fire_dir newline
  prompt_char
)


##########################
# OMZ Libs and Plugins   #
##########################
# # Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up
# ie. some settings help zsh-autosuggestions to clear after tab completion
zi wait lucid for \
    OMZL::compfix.zsh \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::functions.zsh \
    OMZL::git.zsh \
    OMZL::history.zsh \
    OMZL::misc.zsh \
    OMZL::key-bindings.zsh \
    OMZL::theme-and-appearance.zsh \
    OMZL::prompt_info_functions.zsh \
# Install OMZ plugin
zi wait lucid for \
    OMZP::git \
    OMZP::gitignore \
    OMZP::autojump \
    OMZP::web-search \
    OMZP::encode64 \
    OMZP::brew \
    OMZP::docker \
    OMZP::docker-compose \
    OMZP::history \
    OMZP::extract \
    OMZP::fzf \
    OMZP::iterm2 \
    OMZP::aws \
    OMZP::globalias \
    OMZP::terraform \
    OMZP::command-not-found \
    OMZP::common-aliases \
# Install OMZ plugin
zi ice wait svn lucid for \
    OMZP::macos \
    OMZP::emoji \
    OMZP::tmux \
    OMZP::history-substring-search \
# Install OMZ autocompletion
zi as"completion" wait lucid for \
    OMZ::plugins/extract/_extract \
    OMZ::plugins/ripgrep/_ripgrep \
    OMZ::plugins/ufw/_ufw \
# Install third party plugin
zi wait lucid for \
    tru2dagame/history-sync \
    tru2dagame/literate-zsh-fzf-snippets \
    Tarrasch/zsh-bd \
    djui/alias-tips \
    paulirish/git-open \
    zdharma-continuum/zsh-navigation-tools \
    Aloxaf/fzf-tab \
    z-shell/z-a-patch-dl\
    z-shell/z-a-bin-gem-node\
    pick"h.sh" atload"unalias h"\
      paoloantinori/hhighlighter \
    pick"sqlite-history.zsh" atload'autoload -Uz add-zsh-hook' \
       larkery/zsh-histdb \
    zsh-users/zsh-history-substring-search

zi wait lucid for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start"\
    zsh-users/zsh-autosuggestions
### End of Zi's plugin install chunk

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

zi ice id-as'my_zshrc' wait'!0' lucid
zi snippet $DOTDIR/my.zshrc

export HISTFILE=$TRU_HISTFILE
export HISTSIZE=500000
export SAVEHIST=100000

# fzf-tab
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ":fzf-tab:*" fzf-flags --color=bg+:99
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # tmux 3.2
#zstyle ':fzf-tab:*' fzf-command 'fzf-tmux'
# zstyle ':fzf-tab:*' switch-group ',' '.'

# end if dumb
fi
