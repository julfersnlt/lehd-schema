# LEHD Schema
This repository contains a restructured version of the lehd schema. The conceptual between this version and previous ones are that generated documentation (html, pdf), binary data files (shapefiles) and schema files are distinct. 

- Schema files and documentation generation are included in the `src`
- Documentation is generated to `gh-pages`
- Binary data files are published on release at [lehd.ces.census.gov](https://lehd.ces.census.gov)

> [Browse the latest versions here](https://jodyhoonstarr.github.io/lehd-schema-refactor)

## Create schema files

### Load the environment vars
```shell
export $(xargs <.env)
```

### HTML docs
```shell
./generate_schema_docs.sh -v $SCHEMA_VERSION
```

### HTML and PDF docs
```shell
./generate_schema_docs.sh -v $SCHEMA_VERSION -p
```

# Reasoning
At the highest level, the existing schema repository uses git improperly to support the publication structure. It breaks file edit histories and duplicates text and binary files alike.

In the current build process neither the source repository nor the published files contain the full set of schema data. The source repo does not contain built docs or binary files and the published schema does not contain the build process, but some still leaks into the asciidoc source. 

The goal is to simplify the build process and use _git and asciidoc as they're intended_.

## Technical notes
Asciidoctor does not include the ability to subset a csv by column. This was a major functionality that a bash wrapper provided. A custom ruby plugin was implemented to handle this case. The extension lives in the `lib/` directory. It is added to asciidoctor when the process runs. E.g.:
```shell
asciidoctor -r ./lib/csvsubcolumn-include-processor.rb ./sample.adoc
```
