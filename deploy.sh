#!/usr/bin/env sh
# abort on errors
set -e
# build
yarn run build
# navigate into the build output directory
cd dist
# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME
git init
git config user.email "matan.yosef02@gmail.com"
git add -A
git commit -m 'RELEASE V1.0.0'
git push -f git@github.com:matanio/simon-plus.git main:gh-pages
cd -