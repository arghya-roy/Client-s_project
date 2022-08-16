#!/bin/bash
admin_username=
admin_token=
dormant_username1=
dormant_username2=
dormant_username3=
dormant_username4=
dormant_username5=


#for dormant_username1-
fork_repo=$(curl -s -u $admin_username:$admin_token https://github.company_name.com/api/v3/users/${dormant_username1}/repos | jq '.[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username1}"
echo "${fork_repo}"


#for dormant_username2-
fork_repo=$(curl -s -u $admin_username:$admin_token https://github.company_name.com/api/v3/users/${dormant_username2}/repos | jq '.[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username2}"
echo "${fork_repo}"


#for dormant_username3-
fork_repo=$(curl -s -u $admin_username:$admin_token https://github.company_name.com/api/v3/users/${dormant_username3}/repos | jq '.[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username3}"
echo "${fork_repo}"


#for dormant_username4-
fork_repo=$(curl -s -u $admin_username:$admin_token https://github.company_name.com/api/v3/users/${dormant_username4}/repos | jq '.[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username4}"
echo "${fork_repo}"


#for dormant_username5-
fork_repo=$(curl -s -u $admin_username:$admin_token https://github.company_name.com/api/v3/users/${dormant_username5}/repos | jq '.[] | select(.fork == true) | .name')
echo "Fork repo of ${dormant_username5}"
echo "${fork_repo}"


