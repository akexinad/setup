ZSH_THEME_GIT_PROMPT_PREFIX=" \u2387  %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function folder_icon() {
    echo "\uea83"
}

function git_icon() {
    echo "\ueafd"   
}

function git_branch_name() {
    branch=$(git symbolic-ref HEAD 2>/dev/null | awk '{FS="/"} {print $NF}' | cut -d/ -f3-)

    if [[ $branch == "" ]]; then
        return
    fi

    parent=$(git show-branch -a | grep '\*' | grep -v `git rev-parse --abbrev-ref HEAD` | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//')
    # parent=$(git log --pretty=format:'%D' HEAD^ | grep 'origin/' | head -n1 | sed 's@origin/@@' | sed 's@,.*@@')
    
    if [[ $parent == "" ]]; then
        echo '\ngit:>> ['$branch']'
        return
    fi

    echo '\ngit:>> ['$parent'] ⇐ ['$branch']'
}

PROMPT='::::
pwd:>> %d $(git_branch_name)
Δ '
