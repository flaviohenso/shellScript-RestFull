#!/bin/bash
echo > response.json

URL_TOKEN=http://192.168.0.154:8080/oauth/token
URL_SERVICO=http://192.168.0.154:8080/produto/sincronizar

echo "Obtendo token de autorização"
echo $URL_TOKEN
echo $URL_SERVICO
curl -X POST -d 'grant_type=client_credentials' --user 'norteng:123' $URL_TOKEN >> response.json

token=$(cat response.json | jq '.access_token')

access_token=${token:1:36} 

echo $access_token

echo "Iniciando requisição de sincronização de produto"
curl -X GET -H "Authorization: bearer $access_token" $URL_SERVICO
