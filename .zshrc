# ENV Variables/PATHs
export ZSH="${HOME}/.oh-my-zsh"
export GOPATH="${HOME}/go"
export GOROOT=/usr/local/go-1.20.5
export GOPATH=$HOME/projects/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/projects/go/bin
export EDITOR=nvim
export KUBE_EDITOR=nvim
export AWS_CLI_AUTO_PROMPT=on-partial
export PATH=/usr/local/bin/:$PATH:$HOME/bin
export PATH="${PATH}:${HOME}/.krew/bin"
export KUBECONFIG=~/.kube/config
export GITLAB_HOME=/srv/gitlab
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH

# ZSH Setup
plugins=(z zsh-autosuggestions zsh-256color aws git docker kubectl terraform zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

export ZSH_THEME="agnoster"

# This needs to be after the autoloads
kubectl completion zsh > ~/.kubectl-completion
source ~/.kubectl-completion
complete -C '/usr/local/bin/aws_completer' aws

# Env Variables
# Extra more custom ENV variables
[[ -f ~/.zsh/envs.zsh ]] && source ~/.zsh/envs.zsh

# Aliases and Functions
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/aliases-work.zsh]] && source ~/.zsh/aliases-work.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh


# Setup Starship prompt
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
eval "$(starship init zsh)"

# Cargo ENV's
#source "$HOME/.cargo/env"

# Setup Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Start Neofetch
macchina
