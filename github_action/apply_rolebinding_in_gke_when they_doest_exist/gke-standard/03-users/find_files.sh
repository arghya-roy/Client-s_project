find . -type f > file
for item in file
do 
  grep "name" $item
done
rm -f file