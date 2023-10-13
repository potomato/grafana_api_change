#!/bin/sh
TARGET=$1
AUTH='YWRtaW46YWRtaW4='

# make folder
curl -H "Authorization: Basic ${AUTH}" "${TARGET}:3000/api/folders" -H 'Content-Type: application/json' -X POST -d '{ "uid": "alert1", "title": "alert1" }' -S -s -o /dev/null

curl -H "Authorization: Basic ${AUTH}" "${TARGET}:3000/api/datasources" -S -s -o /dev/null

VERSION=$(curl -H "Authorization: Basic ${AUTH}" "${TARGET}:3000/api/health" -s | jq '.version')
DATASOURCE=$(curl -H "Authorization: Basic ${AUTH}" "${TARGET}:3000/api/datasources" -s | jq '.[0].uid')

printf "\nGrafana version is ${VERSION}\n"

printf "\nPosting alert with: $(grep "for" alert5m.json)\nResponse:\n"
sed "s/DATASOURCEUID/${DATASOURCE}/g" alert5m.json | curl -H "Authorization: Basic ${AUTH}" "${TARGET}:3000/api/v1/provisioning/alert-rules" -H 'Content-Type: application/json' -X POST --data-binary @-

printf "\n\n"

printf "\nPosting alert with: $(grep "for" alert300Bn.json)\nResponse:\n"
sed "s/DATASOURCEUID/${DATASOURCE}/g" alert300Bn.json | curl -H "Authorization: Basic ${AUTH}" "${TARGET}:3000/api/v1/provisioning/alert-rules" -H 'Content-Type: application/json' -X POST --data-binary @-

printf "\n\n"
