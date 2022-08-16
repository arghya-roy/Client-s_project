set -e

# Function to display commands echo_exec() {
echo_exec() {
echo "+ \$ $*"
  "$@"
}
#git@gitlab.com:username/CLIENT/PROJECT-NAME.git 
sourceRepo="$1" 
#git@github.com:username/CLIENT-PROJECT-NAME.git 
destRepo="$2"
# Strip everything before the ":" to get the repo name. 
sourcePath=${sourceRepo#:*} 
sourceName=$(basename $sourcePath) 
destPath=${destRepo#:*} 
destName=$(basename $destPath) 
# Renove the .git file extension 
destShortName={destName%.*}

read -p "Do you want to OVERWRITE the ${destRepo} ? y/[n] " varAccept
varAccept=${varAccept:-n} 
 if [[ $varAccept =~ ^[yY]  ]]; then

  echo_exec git clone --bare ${sourceRepo}
  echo exec cd ${sourceName} 
  echo_exec git push --mirror ${destRepo}
  echo exec cd .. 
  echo exec rm -rf ${sourceName} 
  echo_exec git clone ${destRepo} 
  echo_exec cd ${destShortName}
 fi