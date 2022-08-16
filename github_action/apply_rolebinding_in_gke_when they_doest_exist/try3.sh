#!/bin/bash
cd ./project-contractor-bindings/ 
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
   filename=$(echo $line | sed 's/ *$//g')  # backtick has been changed to $() as per requirement
   echo
   echo "The file name is  $filename"
   echo
   echo "getting the namespace name of $filename"
   ns_name=$(yq e '.metadata.namespace' - < $filename)

   if [ "$ns_name" = "null" ]; then   # Spaces are already given here
    echo "ns_name is not maintained in $filename, So exiting this script with exit 1" # gives exit 1, if namespace is not maintained
    exit 1
    else
    echo "ns_name is maintained"
   fi
   echo
   echo "The namespace name of $filename is $ns_name"
   echo

   echo "getting rolebinding name from $filename"
   rb_name=$(yq e '.metadata.name' - < $filename)
   echo
   echo "The rolebinding name of $filename is $rb_name"
   echo

   
   # check is the rolebinding already exists or it is a new rolebinding
   rb_existance_check=$(kubectl get pods --namespace=$ns_name | awk '{print $1}' | grep "\<$rb_name\>")
   if [ "$rb_existance_check" == "$rb_name" ]; then 
    echo "The rolebinding name $rb_name is already exist and showing the yaml file"
    echo
    kubectl get -o yaml pods $rb_name -n $ns_name 
    else
    echo "The rolebinding name $rb_name is not already exist, It is a new rolebinding and showing the yaml file"
    cat $filename
   fi
   #####################################################################################################################

   echo " Applying $filename -n $ns_name file"
   kubectl apply -f $filename -n $ns_name
done < $filepath
rm -f $filepath 
echo
echo "showing current rolebindings on the this cluster after apply" 
kubectl get rolebindings --all-namespaces
echo