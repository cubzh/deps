#!/bin/bash

# exit when any command fails
set -e

# download tool
rm -rf ./buildpatchtool
mkdir ./buildpatchtool
curl -L -o ./buildpatchtool/tool.zip https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/BuildPatchTool.zip

# unzip tool
unzip -u -d ./buildpatchtool/tool ./buildpatchtool/tool.zip

rm ./buildpatchtool/tool.zip