#!/bin/bash

cd docs
rm -Rf *
cd ..
hugo
git add docs/*
git commit -m "publishing"
git push