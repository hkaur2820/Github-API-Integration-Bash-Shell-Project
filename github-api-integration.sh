#!/bin/bash
####
# Author: Harman Kaur
# Date: 5 Feb 2024
# Version: v1
#
# Usage:Please provide your github token and rest api to this script as an arguments.
#
#####


if [ ${#@} -lt 2 ];
then
            echo "Please provide your [your github token] [REST expression]"
            exit 1;
fi

#Github token is your Personal access Token. To create, Go to your profile> Developer settings > Fine Grained Tokens>Create one and save it securely.
#REST expressions depends on the your request that you would like to make.
#Example: /repos/{Owner}/{repo}/events

GITHUB_TOKEN=$1
GITHUB_REST_API=$2

GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

tempfile=`basename $0`
TMPFILE=`mktemp /tmp/${tempfile}.XXXXX` || exit 1


function restapi_call
{
    curl -s $1 -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN" >> $TMPFILE
}

restapi_call "https://api.github.com${GITHUB_REST_API}"

cat $TMPFILE


