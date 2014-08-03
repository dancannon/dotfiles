# Shell configuration
COMPLETION_WAITING_DOTS="true"
unsetopt correct

source $HOME/src/github.com/zsh-users/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle brew
antigen bundle gem
antigen bundle git
antigen bundle git-flow-avh
antigen bundle gitignore
antigen bundle osx
antigen bundle sublime
antigen bundle golang
antigen bundle autojump
antigen bundle docker
antigen bundle vagrant
antigen bundle vagrant
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme "agnoster"

# Tell antigen that you're done.
antigen apply

# misc settings
export VISUAL=vim
export EDITOR=$VISUAL
export DEFAULT_USER="dancannon"
export DOCKER_HOST=tcp://192.168.59.103:2375

# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Go specific config
export GOPATH=$HOME

# Improve ZSH history complete
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# misc completions
source /Library/Ruby/Gems/2.0.0/gems/tmuxinator-0.6.8/completion/tmuxinator.zsh

# OS-specific configuration
case $(uname) in
  ('Darwin')        # OSX

    # Add up Homebrew's Python binary directory to the path
    export PATH=/usr/local/share/python:$PATH

    # Give precedence to user/local/bin because that's where Homebrew installs their stuff
    export PATH=/usr/local/sbin:$PATH
    export PATH=/usr/local/bin:$PATH

    # Add homebrew commandline completion file
    completion_file="$(brew --prefix)/Library/Contributions/brew_bash_completion.zsh"
    if [ -f $completion_file ]; then
      source $completion_file
    fi

  ;;
esac

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
