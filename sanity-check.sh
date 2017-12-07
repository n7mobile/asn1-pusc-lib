#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUT_DIR=${DIR}/.build
MODULE_SCHEMA_FILE=asn1-lib-module-schema.json
GENERAL_SCHEMA_FILE=asn1-lib-general-schema.json
URL=https://raw.githubusercontent.com/n7mobile/asn1scc.IDE/master/schemas
JSON_SCHEMA_URL=http://json-schema.org/draft-04/schema

rm -rf ${OUT_DIR}
mkdir -p ${OUT_DIR} || { echo "Error creating directory" ; exit 1 ; }

printf "\n\nGenerating Makefile files...\n"
(cd ${OUT_DIR} && qmake ../) || { echo  "Error generating makefile" ; exit 1 ; }

printf "\n\nGenerating and building C files...\n"
make -C ${OUT_DIR} || { echo "Error building C files" ; exit 1 ; }

printf "\n\nDownloading JSON Schema schema...\n"
(cd ${OUT_DIR} && wget --no-cache ${JSON_SCHEMA_URL}) \
    || { echo "Error getting json schema base" ; exit 1 ; }

printf "\n\nDownloading and validating module schema...\n"
(cd ${OUT_DIR} && wget --no-cache ${URL}/${MODULE_SCHEMA_FILE}) \
    || { echo "Error getting module json-schema" ; exit 1 ; }
jsonschema -i ${OUT_DIR}/${MODULE_SCHEMA_FILE} ${OUT_DIR}/schema \
           || { echo "Invalid JSON schema" ; exit 1 ; }

printf "\n\nDownloading and validating general info schema...\n"
(cd ${OUT_DIR} && wget --no-cache ${URL}/${GENERAL_SCHEMA_FILE}) \
    || { echo "Error getting general json-schema" ; exit 1 ; }
jsonschema -i ${OUT_DIR}/${GENERAL_SCHEMA_FILE} ${OUT_DIR}/schema \
           || { echo "Invalid JSON schema" ; exit 1 ; }

printf "\n\nValidating modules metadata...\n"
(find ${DIR} -name meta.json -print0 \
        | xargs --verbose -I{} -0 jsonschema -i {} ${OUT_DIR}/${MODULE_SCHEMA_FILE}) \
    || { echo  "Error validating module's metadata" ; exit 1 ; }

printf "\n\nValidating general info...\n"
jsonschema -i ${DIR}/info.json ${OUT_DIR}/${GENERAL_SCHEMA_FILE} \
    || { echo "Error validating general metadata" ; exit 1 ; }
