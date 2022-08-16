#!/bin/bash
#curl -i -u demo4556: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 https://api.github.com/orgs/demo4556/repos

# curl -i "https://api.github.com/users/octocat/repos?type=fork" jq '.[] | select(.fork == true) | .name'


# curl -s https://api.github.com/users/arghya-roy/repos | jq '.[] | select(.fork == true) | .name'


# fork_repo=$( curl -s https://api.github.com/users/arghya-roy/repos | jq '.[] | select(.fork == true) | .name')
# echo "${fork_repo}"

#curl -s https://api.github.com/users/arghya-roy/repos?type=fork | jq '.[] | .name'

# curl -H "Authorization: token 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" https://api.github.com/issues

var1=$(tail -2 dormant_users.txt)
echo "${var1}"
