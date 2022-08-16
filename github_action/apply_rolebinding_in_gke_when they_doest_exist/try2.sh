# cd ./gke-standard/03-users/project-contractor-bindings/ 
# filepath=$(mktemp)
# ls > $filepath


# echo
# echo "showing current rolebindings on the this cluster before apply"
# kubectl get rolebindings --all-namespaces
# echo

# while read -r line;
# do
#    # echo "$line" ;
#    filename=`echo $line | sed 's/ *$//g'`
#    echo
#    echo "The file name is  $filename"
#    echo
#    ns_name=$(yq e '.metadata.namespace' - < $filename)
#    #####################
#    if [ "$ns_name" = "null" ]; then
#     echo "ns_name is not maintained so assigning ns_name=default"
#     ns_name=default
# else
#     echo "ns_name is maintained"
# fi
#    ####################
#    echo "The namespace name of $filename is $ns_name"
#    echo
#    echo " Applying $filename -n $ns_name file"
#   # kubectl apply -f $filename -n $ns_name
# done < $filepath
# rm -f $filepath 

# echo "showing current rolebindings on the this cluster after apply" 
# kubectl get rolebindings --all-namespaces
# echo

#!/bin/bash
cd ./gke-standard/03-users/project-contractor-bindings/ 
filepath=$(mktemp)
echo "the temp file path is $filepath"
echo
ls > $filepath

echo
echo "showing current rolebindings on the this cluster before apply"
echo
kubectl get rolebindings --all-namespaces
echo

while read -r line;
do
   filename=`echo $line | sed 's/ *$//g'`
   echo
   echo "The file name is  $filename"
   echo
   ns_name=$(yq e '.metadata.namespace' - < $filename)

   if [ "$ns_name" = "null" ]; then
    echo "ns_name is not maintained so assigning ns_name=default"
    ns_name=default
    else
    echo "ns_name is maintained"
   fi
   echo
   echo "The namespace name of $filename is $ns_name"
   echo
   echo " Applying $filename -n $ns_name file"
  # kubectl apply -f $filename -n $ns_name
done < $filepath
rm -f $filepath 
echo
echo "showing current rolebindings on the this cluster after apply" 
kubectl get rolebindings --all-namespaces
echo