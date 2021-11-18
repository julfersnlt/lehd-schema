# LEHD Schema
This repository contains a restructured version of the lehd schema. The conceptual between this version and previous ones are that generated documentation (html, pdf), binary data files (shapefiles) and schema files are distinct. 

- Schema files and documentation generation are included in the `src`
- Documentation is generated to `gh-pages`
- Binary data files are published on release at [lehd.ces.census.gov](https://lehd.ces.census.gov)

# Reasoning
At the highest level, the existing schema repository uses git improperly to support the publication structure. It breaks file edit histories and duplicates text and binary files alike.

In the current build process neither the source repository nor the published files contain the full set of schema data. The source repo does not contain built docs or binary files and the published schema does not contain the build process, but some still leaks into the asciidoc source. 

The goal is to simplify the build process and use _git and asciidoc as they're intended_.


## Process
Set a working directory
```shell
schema_wd=/some/path
```

Get the existing public schemas
```shell
cd $schema_wd
mkdir public-lehd-schemas && cd public-lehd-schemas
wget -r -np -nH --cut-dirs=2 -R "index.html*" -R "*.zip" https://lehd.ces.census.gov/data/schema/
```

Get the existing git schemas
```shell
cd $schema_wd
git clone https://github.com/LEDApplications/lehd-schema.git
```

Migrate the existing schema structure into git
```shell
./migrate_schema.sh $schema_wd/public-lehd-schemas $schema_wd/lehd-schema
```

## TODO
1. ~~Remove bash-isms~~
2. Correct asciidoc format
   1. ~~remove internal adoc link refs~~
   2. parameterize vars (e.g. ext-relative, schema version)
   3. add step to build composite files e.g. `label_geography.csv`
   4. auto pull version text files (search for `wget` or `curl` to find)
3. build changelog process (no longer part of the docs themselves)
4. Create asciidoc build process
5. Create `gh-pages` build process and index page
6. Migrate existing generated docs to `gh-pages`
7. Publish releases, add change-notes
8. Rework `naming_convention.csv` to not break asciidoc formatting

## Technical notes
Asciidoctor does not include the ability to subset a csv by column. This was a major functionality that a bash wrapper provided. A custom ruby plugin was implemented to handle this case. The extension lives in the `lib/` directory. It is added to asciidoctor when the process runs. E.g.:
```shell
asciidoctor -r ./lib/csvsubcolumn-include-processor.rb ./sample.adoc
```

## Create schema files
```shell
./generate_schema_docs.sh -v V1.2.3
```