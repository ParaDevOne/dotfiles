#!/usr/bin/env zsh
# Git Aliases - Versión mínima standalone (SIN oh-my-zsh)
# Uso: source git-aliases.zsh en tu .zshrc

# ============================================================================
# FUNCIONES IMPRESCINDIBLES (las 4 que no pueden faltar)
# ============================================================================

# Obtener rama actual - CRÍTICA para todos los aliases dinámicos
function git_current_branch() {
  git symbolic-ref --short HEAD 2>/dev/null || \
  git rev-parse --short HEAD 2>/dev/null || return 1
}

# Detectar rama principal (main/master) - CRÍTICA
function git_main_branch() {
  git rev-parse --git-dir &>/dev/null || return

  local ref
  # Buscar en orden de prioridad
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,master}; do
    if git show-ref -q --verify $ref 2>/dev/null; then
      echo ${ref:t}
      return 0
    fi
  done

  # Fallback a remote HEAD
  local remote
  for remote in origin upstream; do
    ref=$(git rev-parse --abbrev-ref $remote/HEAD 2>/dev/null)
    if [[ $ref == $remote/* ]]; then
      echo ${ref#"$remote/"}
      return 0
    fi
  done

  echo master
  return 1
}

# Detectar rama de desarrollo - ÚTIL
function git_develop_branch() {
  git rev-parse --git-dir &>/dev/null || return

  local branch
  for branch in dev devel develop development; do
    if git show-ref -q --verify refs/heads/$branch 2>/dev/null; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}

# Ir a la raíz del repo - IMPRESCINDIBLE
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

# ============================================================================
# ALIASES BÁSICOS - STATUS/INFO
# ============================================================================

alias g='git'
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'

# ============================================================================
# ALIASES - ADD (staging)
# ============================================================================

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gap='git add --patch'

# ============================================================================
# ALIASES - COMMIT
# ============================================================================

# Commits básicos
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gca='git commit --verbose --all'

# Commits con signoff
alias gcs='git commit --gpg-sign'
alias gcasm='git commit --all --signoff --message'

# Amend commits
alias gc!='git commit --verbose --amend'
alias gca!='git commit --verbose --all --amend'
alias gcn!='git commit --verbose --no-edit --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'

# Fixup/Autosquash
alias gcf='git commit --fixup'

# ============================================================================
# ALIASES - BRANCHES
# ============================================================================

alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbm='git branch --move'
alias gbr='git branch --remote'

# Ramas "gone" (borradas en remoto)
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | awk "{print \$1}" | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | awk "{print \$1}" | xargs git branch -D'

# ============================================================================
# ALIASES - CHECKOUT/SWITCH
# ============================================================================

alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'

# Switch (Git 2.23+)
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(git_main_branch)'
alias gswd='git switch $(git_develop_branch)'

# ============================================================================
# ALIASES - DIFF
# ============================================================================

alias gd='git diff'
alias gdca='git diff --cached'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'
alias gdt='git diff-tree --no-commit-id --name-only -r'

# ============================================================================
# ALIASES - FETCH
# ============================================================================

alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

# ============================================================================
# ALIASES - PULL
# ============================================================================

alias gl='git pull'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'

# Pull de rama actual desde origin
alias ggl='git pull origin $(git_current_branch)'
alias gprom='git pull --rebase origin $(git_main_branch)'

# ============================================================================
# ALIASES - PUSH
# ============================================================================

alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpv='git push --verbose'
alias gpu='git push upstream'

# Push de rama actual
alias ggp='git push origin $(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

# Push all + tags
alias gpoat='git push origin --all && git push origin --tags'

# ============================================================================
# ALIASES - LOG
# ============================================================================

alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glg='git log --stat'
alias glgp='git log --stat --patch'

# Log con formato pretty
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'

# ============================================================================
# ALIASES - MERGE/REBASE
# ============================================================================

# Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmom='git merge origin/$(git_main_branch)'
alias gms='git merge --squash'

# Rebase
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'

# ============================================================================
# ALIASES - RESET/RESTORE
# ============================================================================

alias grh='git reset'
alias grhh='git reset --hard'
alias grhs='git reset --soft'
alias gpristine='git reset --hard && git clean -dfx'

# Restore (Git 2.23+)
alias grs='git restore'
alias grst='git restore --staged'

# ============================================================================
# ALIASES - STASH
# ============================================================================

alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gstc='git stash clear'
alias gsts='git stash show --patch'

# ============================================================================
# ALIASES - CHERRY-PICK
# ============================================================================

alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# ============================================================================
# ALIASES - REMOTE
# ============================================================================

alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grset='git remote set-url'

# ============================================================================
# ALIASES - OTROS ESENCIALES
# ============================================================================

alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'
alias gcount='git shortlog --summary --numbered'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias grm='git rm'
alias grmc='git rm --cached'
alias gsh='git show'
alias grev='git revert'
alias grf='git reflog'
alias gta='git tag --annotate'
alias gtl='git tag --sort=-v:refname -n --list'

# ============================================================================
# WORKTREE (Git 2.5+)
# ============================================================================

alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtrm='git worktree remove'

# ============================================================================
# CONFIRMACIÓN DE CARGA
# ============================================================================

print -P "%F{green}✓%f Git aliases cargados (%F{cyan}$(alias | grep -c "^g")%f aliases)"
