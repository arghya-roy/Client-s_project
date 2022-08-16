dir=$(pwd)

git clone https://github.com/group2367/testing1.git

cd testing1
git branch -a > $dir/branch.txt
sed -i 1,2d $dir/branch.txt  # delete 1st two lines
sed 's/\// /g' $dir/branch.txt > $dir/branch2.txt  # replace / with space
awk '{print $3}' $dir/branch2.txt > $dir/branch3.txt # pick 3rd word
sed -r 's/\s+//g' $dir/branch3.txt > $dir/branch4.txt  # delete extra space

cd ..
rm -rf testing1

for item in `cat branch4.txt`
do
branch_name=`echo "${item}" | sed 's/ *$//g'`
echo
git clone https://gitlab.com/group2367/testing1.git
cd testing1
git checkout ${item}
rm -rf .git
rm -rf Software_Provisioning.zip

cd ..

git clone https://github.com/arghya-roy/testing100.git
cd testing100
git checkout -b ${item}
git checkout ${item}

cd ..

mv ./testing1/* ./testing100
cd testing 100
git add .
git commit -m "deleting large file"
git branch -M ${item}

git remote add origin https://github.com/arghya-roy/testing100.git
git push -u origin ${item}
cd ..
rm -rf testing1
rm -rf testing100
# if [ $? -eq 0 ];
# then
#        echo "testfile1 is deleted from ${item} branch"
# else
#         echo "testfile1 is not present in ${item} branch"
# fi
# echo 
done


