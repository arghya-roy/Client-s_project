echo "create ssh dir"
mkdir -p ssh && echo "$FEWSNET_CI_SSH_KEY" > ssh/id_rsa && chmod 0755 ssh/id_rsa
echo "known hosts file"
echo "$FEWNET_KNOWN_HOSTS" > ssh/known_hosts && chmod 0755 ssh/known_hosts
ls -ltrh ssh/