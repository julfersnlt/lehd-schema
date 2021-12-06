# Previous Instructions

How to build older versions of this schema. 

## Build an earlier version of the schema

> Earlier iterations of this schema do not contain these instructions. Either open this doc in a web browser or clone the repo and work from the copy.


```shell
# list the available tags
git tag

# checkout the tag to a new branch
git checkout tags/V4.7.0 -b V4.7.0

# build the schema docs
cd src
./write_all.sh official

# copy the output files to dist/
cd ..
mkdir dist
cp src/*.csv dist/
mv src/*.pdf dist/
mv src/*.html dist/

# reset the source 
git reset --hard HEAD

# verify that there are no unexpected changes
git status

# move the dist directory to deploy as needed
mv dist /path/to/deploy

# cleanup created branch and revert to main
git checkout main
git branch -d V4.7.0
```
