source ~/.local/share/omarchy/default/bash/rc
# source /usr/share/nvm/init-nvm.sh

set -o vi

# Prompt
PS1="[\u:\W/]\$ "

# Omarchy - change defaults
unalias ls
unalias lsa
unalias lt
unalias lta
unalias ff
unalias cd

# Aliases
alias ll='ls -lahG --color=always'
alias gits='git status'
alias gitd='git diff --color'
alias gitt='git log -1'
alias vim='nvim'
alias nvim='NVIM_APPNAME=nvim-lazyvim /usr/bin/nvim'
alias nvim-astro='NVIM_APPNAME=nvim-astrovim /usr/bin/nvim'
alias bashrc-reload='source ~/.bashrc'
alias bashrc-edit='nvim ~/.bashrc'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Bartib
export BARTIB_FILE=~/bartib-timelog

# SSH
# Used by `ssh-agent` systemd service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# SpecHub AWS CLI
sts_spechub() {
  local profile="spechub"

  if aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
    echo "✅ Already authenticated with profile: $profile"
  else
    echo "🔐 Attempting to authenticate with profile: $profile"
    if ! aws sso login --no-browser --profile "$profile"; then
      echo "❌ Authentication failed for profile: $profile" >&2
      return 1
    fi
    echo "✅ Authenticated with profile: $profile"
  fi

  local creds
  if ! creds=$(aws configure export-credentials --profile "$profile" 2>/dev/null); then
    echo "❌ Failed to export credentials for profile: $profile" >&2
    return 1
  fi

  export AWS_ACCESS_KEY_ID=$(jq -r .AccessKeyId <<<"$creds")
  export AWS_SECRET_ACCESS_KEY=$(jq -r .SecretAccessKey <<<"$creds")
  export AWS_SESSION_TOKEN=$(jq -r .SessionToken <<<"$creds")
  export AWS_DEFAULT_REGION=$(aws configure get region --profile "$profile")

  echo "✅ Exported temporary credentials to your environment for profile: $profile"
}
