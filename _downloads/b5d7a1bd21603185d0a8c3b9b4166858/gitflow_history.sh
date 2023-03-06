#!/bin/bash

counter=1

commit () {
    git checkout $1
    if [ -e "${1}_log" ] 
    then
        echo "$commit #$counter from [$1]" >> ${1}_log
        git add ${1}_log
    else
        echo "$commit #$counter from [$1]" >> ${1}_log
    fi
    git commit -a --allow-empty -m "[$1] $counter"
    counter=$((counter+1))
    sleep 1
}

new_branch () {
    git checkout $1
    git checkout -b $2
}

merge () {
    git checkout $1
    git merge --no-ff --no-edit $2
    counter=$((counter+1))
    sleep 1
}

rebase () {
    git rebase --keep-empty $1 $2
    counter=$((counter+1))
    sleep 1
}

git init
echo "started master_log at commit #$counter" >> master_log
git add master_log

commit master
new_branch master develop
commit develop
commit develop
commit develop
new_branch develop feature-1
commit feature-1
commit develop
new_branch develop feature-2
commit feature-2
new_branch master hotfixes
commit hotfixes
merge master hotfixes
commit feature-1
commit feature-2
merge develop hotfixes
commit feature-2
merge develop feature-2
new_branch develop release-1
commit release-1
commit release-1
merge develop release-1
commit feature-1 
commit release-1
new_branch develop feature-3
commit feature-3
commit release-1
commit feature-3
merge develop release-1
merge master release-1
commit feature-3
commit feature-1
merge develop feature-3
merge develop feature-1
new_branch develop release-2
merge develop release-2
merge master release-2
