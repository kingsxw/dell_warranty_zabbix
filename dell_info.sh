#!/bin/bash

client_id=$1
client_secret=$2
service_tag=$(echo $3| cut -d"-" -f2)

oauth2_url=https://apigtwb2c.us.dell.com/auth/oauth/v2/token
warranty_url=https://apigtwb2c.us.dell.com/PROD/sbil/eapi/v5/asset-entitlements

oauth2_token=$(
    curl -s $oauth2_url \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -X POST \
        -d 'client_id='"$client_id"'' \
        -d 'client_secret='"$client_secret"'' \
        -d 'grant_type=client_credentials'
)

warranty_token=$(echo $oauth2_token | jq -r '.access_token')

warranty_detail=$(
    curl -s ''"$warranty_url"'?servicetags='"$service_tag"'&Method=GET' \
        -H 'Accept: application/json' \
        -H 'Authorization: Bearer '"${warranty_token}"''
)

echo "${warranty_detail:1:${#string}-1}"
