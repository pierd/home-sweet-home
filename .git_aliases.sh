# Git aliases, shared by zsh and bash (keep it working in bash 3.2).
# A subset of oh-my-zsh's git plugin, with the same names and meanings.

git_main_branch() {
    local remote ref
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
        if git show-ref -q --verify "$ref"; then
            echo "${ref##*/}"
            return
        fi
    done
    for remote in origin upstream; do
        ref=$(git rev-parse --abbrev-ref "$remote/HEAD" 2> /dev/null)
        if [[ $ref == "$remote"/* ]]; then
            echo "${ref#"$remote"/}"
            return
        fi
    done
    echo master
}

git_develop_branch() {
    local branch
    for branch in dev devel develop development; do
        if git show-ref -q --verify "refs/heads/$branch"; then
            echo "$branch"
            return
        fi
    done
    echo develop
}

git_current_branch() {
    git symbolic-ref --quiet --short HEAD 2> /dev/null
}

# Basics
alias g='git'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'
alias gsh='git show'
alias gshs='git show --stat'
alias grf='git reflog'
alias ghh='git help'
alias gcount='git shortlog --summary --numbered'

# Add
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'

# Apply, bisect, blame
alias gap='git apply'
alias gapt='git apply --3way'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gbl='git blame -w'

# Branch
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remotes'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'

# Checkout, switch
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'

# Cherry-pick, revert
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'

# Clone, clean
alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'

# Commit
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcn='git commit --verbose --no-edit'
alias gcn!='git commit --verbose --no-edit --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcam='git commit --all --message'
alias gcmsg='git commit --message'
alias gcfu='git commit --fixup'

# Diff
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'
alias gdup='git diff @{upstream}'

# Fetch
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune --jobs=10'
alias gfo='git fetch origin'

# Log
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glom='git log --oneline --decorate --color $(git_main_branch)..'

# Ls-files
alias gfg='git ls-files | grep'

# Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms="git merge --squash"
alias gmff="git merge --ff-only"
alias gmom='git merge origin/$(git_main_branch)'
alias gmum='git merge upstream/$(git_main_branch)'

# Pull
alias gl='git pull'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gprom='git pull --rebase origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias ggpull='git pull origin "$(git_current_branch)"'
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'

# Push
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease --force-if-includes'
alias gpf!='git push --force'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
alias gpv='git push --verbose'
alias gpod='git push origin --delete'
alias gpu='git push upstream'
alias ggpush='git push origin "$(git_current_branch)"'

# Rebase
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grbd='git rebase $(git_develop_branch)'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbum='git rebase upstream/$(git_main_branch)'
alias grbmi='git rebase $(git_main_branch) --interactive'

# Remote
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grup='git remote update'

# Reset, restore, rm
alias grh='git reset'
alias gru='git reset --'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grm='git rm'
alias grmc='git rm --cached'

# Stash
alias gsta='git stash push'
alias gstu='gsta --include-untracked'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'

# Submodule
alias gsi='git submodule init'
alias gsu='git submodule update'
alias gsuri='git submodule update --recursive --init'

# Tag
alias gta='git tag --annotate'
alias gtv='git tag | sort -V'

# WIP
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'

# Worktree
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
