#!/bin/bash

PARAMETERS=$(cat add_parameters.json)

for row in $(echo "${PARAMETERS}" | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }

    NAME=$(_jq '.Name')
    VALUE=$(_jq '.Value')
    TYPE=$(_jq '.Type')

    echo "Adding parameter: $NAME"
    aws ssm put-parameter --name "$NAME" --value "$VALUE" --type "$TYPE" --overwrite

    if [ $? -eq 0 ]; then
        echo "Successfully added parameter: $NAME"
    else
        echo "Failed to add parameter: $NAME"
    fi
done