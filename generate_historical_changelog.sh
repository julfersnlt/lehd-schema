#!/usr/bin/env bash

public_schema_source_path=$1
output_adoc=$2

rm -rf $output_adoc

# generate the adoc header
cat << EOF > $output_adoc
= LEHD Schema Changelog ({schemaversion})
Contact Us <ces.qwi.feedback@census.gov>
:ext-relative: {outfilesuffix}
:icons: font
:linkcss:
:copycss:
:toc:
:numbered:
:toclevels: 4
:sectnumlevels: 4

[NOTE]
.Important
==============================================
Feedback is welcome.
Please write us at link:mailto:ces.qwi.feedback@census.gov?subject=LEHD_Schema[ces.qwi.feedback@census.gov].
==============================================

EOF

for dir in ${public_schema_source_path}/*/; do
  schema_version="$(basename $dir)"

  # validate that the schema is in semver-ish form (e.g. v1.2 or V1.2.0)
  if ! [[ $schema_version =~ ^v[0-9]+\.[0-9]+ || $schema_version =~ ^V[0-9]+\.[0-9]+ ]]; then
    continue
  fi

  echo "Processing ${schema_version}..."
  echo "== ${schema_version}" >> $output_adoc
  echo "" >> $output_adoc

  change_files=$(find $dir -type f -name "CHANGES*")
  for change_file in $change_files; do
    cat $change_file >> $output_adoc
  done

done

echo "Done."