#!/bin/bash
echo > response.json

URL_TOKEN=http://<ip>:8080/oauth/token
URL_SERVICO=http://<ip>:8080/produto/sincronizar

echo "Obtendo token de autorização"
echo $URL_TOKEN
echo $URL_SERVICO
curl -X POST -d 'grant_type=client_credentials' --user <'password here'> $URL_TOKEN >> response.json

token=$(cat response.json | jq '.access_token')

access_token=${token:1:36} 

echo $access_token

echo "Iniciando requisição de sincronização de produto"
curl -X GET -H "Authorization: bearer $access_token" $URL_SERVICO
