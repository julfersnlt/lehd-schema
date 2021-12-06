# Instructions

How to build the docs. 

## Build the current version of the schema

1. Load the schema version from the environment variable
```shell
export $(xargs <.env)
```

2. Build the docs
```shell
# html only
./generate_schema_docs.sh -v $SCHEMA_VERSION
# html and pdf
./generate_schema_docs.sh -v $SCHEMA_VERSION -p
```

3. Deploy the output files

```shell
# csv, html, and pdf are in the ./dist directory
cp ./dist /path/to/schemas/$SCHEMA_VERSION -r
```