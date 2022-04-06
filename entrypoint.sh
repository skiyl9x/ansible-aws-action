#!/bin/sh

#set -e

#echo "running entrypoint command(s)"

sh -c "$INPUT_COMMAND"
response=$(sh -c " $INPUT_COMMAND")
#echo $response
#echo "::set-output name=response::$response"
