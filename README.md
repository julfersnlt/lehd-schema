[![build adocs](https://github.com/jodyhoonstarr/lehd-schema-refactor/actions/workflows/adocs-build.yaml/badge.svg)](https://github.com/jodyhoonstarr/lehd-schema-refactor/actions/workflows/adocs-build.yaml)

# LEHD Schema

This repository contains a restructured version of the lehd schema. The conceptual between this version and previous ones are that generated documentation (html, pdf), binary data files (shapefiles) and schema files are distinct. 

- Schema files and documentation generation are included in the `src`
- Documentation is generated to `gh-pages`
- Binary data files are published on release at [lehd.ces.census.gov](https://lehd.ces.census.gov)



## Instructions

> Github automatically builds the documentation from the source code. No need to run the steps below during development.

How to build the schema documentation. These steps only need to be run when deploying an official release. Choose the appropriate instruction set below.

### Current (V4.8.3 or later)
See the [instructions document](./docs/instructions.md#build-the-current-version-of-the-schema) for a step-by-step guide to building the current version of the schema.

### Deprecated (V4.8.2 or earlier)
See the [previous instructions document](./docs/previous-instructions.md#build-an-earlier-version-of-the-schema) to build an earlier version of the schema.


