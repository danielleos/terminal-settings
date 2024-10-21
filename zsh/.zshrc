# ============================
# PATH CONFIG
# ============================
export PATH=/usr/local/bin:$HOME/bin:$HOME/go/bin:$HOME/.npm-global/bin:/opt/homebrew/opt/jpeg/bin:$PATH

export LDFLAGS="-L/opt/homebrew/opt/jpeg/lib"
export CPPFLAGS="-I/opt/homebrew/opt/jpeg/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/jpeg/lib/pkgconfig"

# ============================
# ZSH CONFIG
# ============================
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="jonathan"
# DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=13
COMPLETION_WAITING_DOTS="true"
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh


# ============================
# CUSTOM PROMPT
# ============================
eval "$(oh-my-posh init zsh)"

# Themes that are kept up-to-date via brew
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/jandedobbeleer.omp.json)"

# Custom theme path
# eval "$(oh-my-posh init zsh --config ~/.adapted-aliens.omp.json)"



# ============================
# ALIASES
# ============================
alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias gch="git fetch && git checkout"
alias gl="git log --oneline --graph"
alias gc="git commit -S -m"
alias ga="git add -A"
alias gf="git fetch"
alias gfp="git fetch && git pull"

# checks out specified branch, fetches and pulls from remote
goupdate() {
  (gch "$@"; gfp)
}

# deletes all local git branches except the one you're going to (which updates)
gbdall() {
  (goupdate "$@"; git branch | grep -v "$@" | xargs git branch -D)
}

alias sourcezsh="source ~/.zshrc"
alias openzsh="open ~/.zshrc"

alias disable="sudo spctl --master-disable"
alias enable="sudo spctl --master-enable"

### kill docker containers and prune them if need be
function dockerkill {
  docker container kill $(docker ps -q);
  echo y | docker system prune;
  echo y | docker volume prune;
}

# ============================
# SSH ALIASES
# ============================
alias sshclear="ssh-add -D"

# need to create an SSH key for git cloning specifying work email below:

# alias ssh<WORK>="sshclear; ssh-add ~/.ssh/id_ed25519_<WORK>"
# alias sshpersonal="sshclear; ssh-add ~/.ssh/id_ed25519_personal"



# ============================
# WORK CONFIG
# ============================




# ============================
# PYTHON CONFIG
# ============================
# eval "$(pyenv init --path)"



# ============================
# NVM CONFIG
# ============================
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ============================
# EXECUTE ON LOAD:
# ============================
# Below is useful if SSH auth via terminal doesn't seem to be working consistently (after machine restart for instance)
# ssh<WORK>
