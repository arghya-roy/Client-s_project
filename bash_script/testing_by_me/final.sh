#!/bin/bash
admin_token=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

for item in `cat dormant_users.txt`
do
myVar=`echo $item | sed 's/ *$//g'`
echo
echo "Username: $myVar"
echo
fork_repo=$( curl -s -H "Authorization: token ${admin_token}" https://api.github.com/search/repositories?q=user:${myVar} | jq '.items[] | select(.fork == true) | .name')
echo "${fork_repo}"
#    for delete_repo in ${fork_repo};
#    do
#    echo
#    delete_repo_name=$(echo ${delete_repo} | cut -d '"' -f 2)
#    echo "repo is - ${delete_repo_name}"
#    curl -s -u $myVar:$admin_token -XDELETE "https://api.github.com/repos/$myVar/$delete_repo_name"
#    echo "${delete_repo_name} is deleted"
#    done
fork_repo=$( curl -s -H "Authorization: token ${admin_token}" https://api.github.com/users/${myVar}/repos | jq '.[] | select(.fork == true) | .name')
echo "${fork_repo}"
#    for delete_repo in ${fork_repo};
#    do
#    echo
#    delete_repo_name=$(echo ${delete_repo} | cut -d '"' -f 2)
#    echo "repo is - ${delete_repo_name}"
#    curl -s -u $myVar:$admin_token -XDELETE "https://api.github.com/repos/$myVar/$delete_repo_name"
#    echo "${delete_repo_name} is deleted"
#    done
done
