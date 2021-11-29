# LEHD Schema
This repository contains a restructured version of the lehd schema. The conceptual between this version and previous ones are that generated documentation (html, pdf), binary data files (shapefiles) and schema files are distinct. 

- Schema files and documentation generation are included in the `src`
- Documentation is generated to `gh-pages`
- Binary data files are published on release at [lehd.ces.census.gov](https://lehd.ces.census.gov)

# Reasoning
At the highest level, the existing schema repository uses git improperly to support the publication structure. It breaks file edit histories and duplicates text and binary files alike.

In the current build process neither the source repository nor the published files contain the full set of schema data. The source repo does not contain built docs or binary files and the published schema does not contain the build process, but some still leaks into the asciidoc source. 

The goal is to simplify the build process and use _git and asciidoc as they're intended_.


## TODO
1. ~~Remove bash-isms~~
2. ~~Correct asciidoc format~~
   1. ~~remove internal adoc link refs~~
   2. ~~parameterize vars (e.g. ext-relative, schema version)~~
   3. ~~add step to build composite files e.g.~~ label_geography.csv removed from build
   4. ~~auto pull version text files (search for `wget` or `curl` to find)~~ hardcoded
3. ~~build changelog process (no longer part of the docs themselves)~~
4. ~~reformat toc~~
5. ~~generate pdfs~~
6. ~~remove `naming_geohi.csv`, `create_naming_geohi.sh`, and any refs (hasn't been updated in a while)~~
7. ~~remove `label_agg_level-reduced.csv` that's been hanging around since 4.1-draft~~
8. ~~Create asciidoc build process~~
9. ~~Create `gh-pages` build process and index page~~
10. ~~Migrate existing generated docs to `gh-pages`.~~
11. ~~Publish releases, add change-notes~~
12. ~~Make asciidoc nav panel bigger~~
13. ~~Fix wide tables adding scrollbars~~ (punting)
14. ~~Rework `naming_convention.csv` to not break asciidoc formatting~~ (punting)
15. ~~Fix j2j "Soon." references, find in docs to see~~(already done)
16. ~~Parameterize the Geovintage/TIGER vintage~~(punting)
17. ~~Parameterize the YYYYQQ string e.g. 2020Q1~~(punting)
18. Update chagelog with description of work done above

## Technical notes
Asciidoctor does not include the ability to subset a csv by column. This was a major functionality that a bash wrapper provided. A custom ruby plugin was implemented to handle this case. The extension lives in the `lib/` directory. It is added to asciidoctor when the process runs. E.g.:
```shell
asciidoctor -r ./lib/csvsubcolumn-include-processor.rb ./sample.adoc
```

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
