#!/bin/bash

while getopts ":g:s:l:" arg; do
  case $arg in
    g) resource_group=$OPTARG;;
    s) storage_account=$OPTARG;;
    l) location=$OPTARG;;
    t) template=$OPTARG;;
  esac
done

echo -e "\e[32mCreate rbac query...\e[0m"
rbac=$( az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }" 2>&1 )
client_id=`echo $rbac |  grep -o -P '(?<="client_id": ").*(?=", "client_secret": ")'`
client_secret=`echo $rbac |  grep -o -P '(?<="client_secret": ").*(?=", "tenant_id": ")'`
tenant_id=`echo $rbac |  grep -o -P '(?<="tenant_id": ").*(?=")'`
subscription_id=$( az account show --query "{ subscription_id: id }" |  grep -o -P '(?<="subscription_id": ").*(?=")')

echo "client_id $client_id"
echo "client_secret $clieclient_secretnt_id"
echo "tenant_id $tenant_id"
echo "subscription_id $subscription_id"
echo "resource_group $resource_group"
echo "storage_account $storage_account"
echo "location $location"

packer build -var 'commit_id=LATEST' \
-var "client_id=$client_id" \
-var "client_secret=$client_secret" \
-var "subscription_id=$subscription_id" \
-var "tenant_id=$tenant_id" \
-var "resource_group=$resource_group" \
-var "storage_account=$storage_account" \
-var "location=$location" \
$template
