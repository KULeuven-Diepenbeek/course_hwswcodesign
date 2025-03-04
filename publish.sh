#!/bin/bash

cd docs
rm -Rf *
cd ..
hugo
git add -u docs
git commit -m "publishing"
git push