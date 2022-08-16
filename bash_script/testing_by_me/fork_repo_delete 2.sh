#!/bin/bash
admin_username=
admin_token=
dormant_username1=
dormant_username2=
dormant_username3=
dormant_username4=
dormant_username5=


#for dormant_username1-
fork_repo=$( curl -s -H "Authorization: token ${admin_token}" https://github.company_name.com/api/v3/search/repositories?q=user:${dormant_username1} | jq '.items[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username1}"
echo "${fork_repo}"
echo 

for delete_repo in ${fork_repo};
do
echo
delete_repo_name=$(echo ${delete_repo} | cut -d '"' -f 2)
echo "repo is - ${delete_repo_name}"
curl -s -u $dormant_username1:$admin_token -XDELETE "https://github.company_name.com/repos/$dormant_username1/$delete_repo_name"
echo "${delete_repo_name} is deleted"
done

#for dormant_username2-
fork_repo=$( curl -s -H "Authorization: token ${admin_token}" https://github.company_name.com/api/v3/search/repositories?q=user:${dormant_username2} | jq '.items[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username2}"
echo "${fork_repo}"
echo 

for delete_repo in ${fork_repo};
do
echo
delete_repo_name=$(echo ${delete_repo} | cut -d '"' -f 2)
echo "repo is - ${delete_repo_name}"
curl -s -u $dormant_username2:$admin_token -XDELETE "https://github.company_name.com/repos/$dormant_username2/$delete_repo_name"
echo "${delete_repo_name} is deleted"
done

#for dormant_username3-
fork_repo=$( curl -s -H "Authorization: token ${admin_token}" https://github.company_name.com/api/v3/search/repositories?q=user:${dormant_username3} | jq '.items[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username3}"
echo "${fork_repo}"
echo 

for delete_repo in ${fork_repo};
do
echo
delete_repo_name=$(echo ${delete_repo} | cut -d '"' -f 2)
echo "repo is - ${delete_repo_name}"
curl -s -u $dormant_username3:$admin_token -XDELETE "https://github.company_name.com/repos/$dormant_username3/$delete_repo_name"
echo "${delete_repo_name} is deleted"
done

#for dormant_username4-
fork_repo=$( curl -s -H "Authorization: token ${admin_token}" https://github.company_name.com/api/v3/search/repositories?q=user:${dormant_username4} | jq '.items[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username4}"
echo "${fork_repo}"
echo 

for delete_repo in ${fork_repo};
do
echo
delete_repo_name=$(echo ${delete_repo} | cut -d '"' -f 2)
echo "repo is - ${delete_repo_name}"
curl -s -u $dormant_username4:$admin_token -XDELETE "https://github.company_name.com/repos/$dormant_username4/$delete_repo_name"
echo "${delete_repo_name} is deleted"
done

#for dormant_username5-
fork_repo=$( curl -s -H "Authorization: token ${admin_token}" https://github.company_name.com/api/v3/search/repositories?q=user:${dormant_username5} | jq '.items[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username5}"
echo "${fork_repo}"
echo 

for delete_repo in ${fork_repo};
do
echo
delete_repo_name=$(echo ${delete_repo} | cut -d '"' -f 2)
echo "repo is - ${delete_repo_name}"
curl -s -u $dormant_username5:$admin_token -XDELETE "https://github.company_name.com/repos/$dormant_username5/$delete_repo_name"
echo "${delete_repo_name} is deleted"
done


#   repo_name


curl -s -u $dormant_username5:$admin_token -XDELETE "https://github.company_name.com/repos/$dormant_username5/"""