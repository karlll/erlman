#!/bin/bash
set -e

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OTP_ROOT="/usr/local/Cellar/erlang/R15B01/lib/erlang/" # Set this to your OTP installation
SRC_FILES=$(find $OTP_ROOT -name '*.erl')
XML_DEST="${SCRIPT_DIR}/../priv/xml/"
EBIN=${SCRIPT_DIR}/../ebin/
for F in $SRC_FILES; do
    FILE=$(basename $F)
    DIR=$(dirname $F)
    cd $DIR
    echo "$FILE in $DIR  . . ."
    erl -pa ${EBIN} -noshell -run edoc_run files [\"$FILE\"] "[{doclet,erlman_doclet},{layout,erlman_layout},{dir,\"${XML_DEST}\"}]"
done



