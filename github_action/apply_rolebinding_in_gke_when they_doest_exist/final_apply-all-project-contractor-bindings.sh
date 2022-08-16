#!/bin/bash

cd ./gke-standard/03-users/project-contractor-bindings/

filepath=$(mktemp)
ls > $filepath

echo "showing current rolebindings on the cluster before apply"
echo
kubectl get rolebindings --all-namespaces
echo

while read -r line;
do
   filename=$(echo $line)
   echo
   echo "The file name is  $filename"
   echo
   ns_name=$(yq e '.metadata.namespace' $filename)

   if [ "$ns_name" = "null" ]; then 
    echo "ns_name is not maintained in $filename, So exiting this script with exit 1" # gives exit 1, if namespace is not maintained
    exit 1
   fi

   if ! kubectl get ns $ns_name &> /dev/null; then
   # if ! kubectl get ns $ns_name > /dev/null; then
   # if ! kubectl get ns $ns_name 2>/dev/null; then 
   # if ! kubectl get ns $ns_name 2&1>/dev/null; then 
    #echo "ns_name $ns_name for $filename is not available inside cluster, So exiting this script with exit 1" # gives exit 1, if namespace is not found inside cluster
    #exit 1
    echo "The namespace $ns_name is not present inside cluster so we are ignoring the kubectl apply rolebinding command for $filename in $ns_name namespace"
    continue
   fi


   echo
   echo "The namespace name of $filename is $ns_name"
   echo

   echo "getting rolebinding name from $filename"
   rb_name=$(yq e '.metadata.name' $filename)
   echo
   echo "The rolebinding name of $filename is $rb_name"
   echo

   rb_existance_check=$(kubectl get pods --namespace=$ns_name | awk '{print $1}' | grep "\<$rb_name\>")
   if [ "$rb_existance_check" == "$rb_name" ]; then 
    echo "The rolebinding name $rb_name is already exist and showing the yaml file"
    echo
    kubectl get -o yaml pods $rb_name -n $ns_name 
    else
    echo "The rolebinding name $rb_name is not already exist, It is a new rolebinding"
   fi
    
   echo " Applying $filename -n $ns_name file"
   kubectl apply -f $filename -n $ns_name
done < $filepath
rm -f $filepath
echo
echo "showing current rolebindings on the cluster after apply"
kubectl get rolebindings --all-namespaces
echo
