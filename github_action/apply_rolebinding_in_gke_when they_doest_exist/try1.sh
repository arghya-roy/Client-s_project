# cd ./gke-standard/03-users/project-contractor-bindings/
# ls > file
# for item in `cat file`
# do
# filename=`echo $item | sed 's/ *$//g'`
# echo
# echo "The file name is  $filename"
# echo
# ns_name=$(yq e '.metadata.namespace' - < $filename)
# echo "The namespace name of $filename is $ns_name"
# echo
# echo " Applying $filename -n $ns_name file"
# # kubectl apply -f $filename -n $ns_name
# done

cd ./gke-standard/03-users/project-contractor-bindings/
filename=$(mktemp)
ls > $filename
echo $filename
cat $filename
# awk '!/file/' file > tmpfile && mv tmpfile file
# rm -rf tmpfile
echo
echo "showing current rolebindings on the this cluster before apply"
# kubectl get rolebindings --all-namespaces
echo

while read -r line;
do
   # echo "$line" ;
   filename=`echo $line | sed 's/ *$//g'`
   echo
   echo "The file name is  $filename"
   echo
   ns_name=$(yq e '.metadata.namespace' - < $filename)
   echo "The namespace name of $filename is $ns_name"
   echo
   echo " Applying $filename -n $ns_name file"
   # kubectl apply -f $filename -n $ns_name
done < $filename
#rm -rf file

echo "showing current rolebindings on the this cluster after apply"
# kubectl get rolebindings --all-namespaces
echo