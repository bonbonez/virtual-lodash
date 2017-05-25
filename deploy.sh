#!/usr/bin/env bash

set -ex;

git config core.filemode false
git config user.name 'smikhalevski'
git config user.email 'smikhalevski@gmail.com'

npm run build;

VERSION=$(npm v lodash version);
if grep -q "$VERSION" package.json;
 then VERSION=$VERSION-$TRAVIS_BUILD_NUMBER;
fi;
npm version "$VERSION" -m 'Release v%s';

cp README.md LICENSE package.json build;
cd build;

npm config set '//registry.npmjs.org/:_authToken' "$NPM_TOKEN";
npm publish;

git remote set-url origin https://${GH_TOKEN}@github.com/smikhalevski/virtual-lodash.git
git push origin HEAD:$TRAVIS_BRANCH;
