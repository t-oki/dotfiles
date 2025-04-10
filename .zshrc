# -------------------------------------
# zplug
# -------------------------------------

export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh

#compile if .zwc is old
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  echo "zcompile .zshrc"
  zcompile ~/.zshrc
fi
if [ ~/.zshenv -nt ~/.zshenv.zwc ]; then
  echo "zcompile .zshenv"
  zcompile ~/.zshenv
fi

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:init.sh
zplug "themes/candy", from:oh-my-zsh, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install(zplug)? [y/N]: "
  if  read -q; then
    echo; zplug install
  fi
fi

zplug load

# -------------------------------------
# Path
# -------------------------------------

export GOPATH=$HOME
export GOROOT="/opt/homebrew/Cellar/go/1.24.1/libexec"
export PATH=$PATH:$GOPATH/bin

export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH=~/.local/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

export PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"

eval "$(rbenv init -)"
eval "$(pyenv init -)"

[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# -------------------------------------
# zsh options
# -------------------------------------

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=32' 'ex=31'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=2

# Curl
setopt nonomatch

## 補完機能の強化
autoload -U compinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt notify

## タブによるファイルの順番切り替えをする
setopt auto_menu

## ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

## Command history configuration
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# -------------------------------------
# Alias
# -------------------------------------

alias q="exit"
alias zshconf="vim ~/.zshrc"
alias sshconf="vim ~/.ssh/config"
alias ping="/sbin/ping"
alias ll='ls -al'
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# -------------------------------------
# Key Binds
# -------------------------------------

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/takuyaoki/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
