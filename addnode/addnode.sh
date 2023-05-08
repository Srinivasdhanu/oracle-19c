#!/bin/sh
#
# $Header: install/utl/scripts/db/addnode/addnode.sh /main/6 2017/03/08 09:44:22 davjimen Exp $
#
# addnode.sh
#
# Copyright (c) 2015, 2017, Oracle and/or its affiliates. All rights reserved.
#
#    NAME
#      addnode.sh - <one-line expansion of the name>
#
#    DESCRIPTION
#      <short description of component this file declares/defines>
#
#    NOTES
#      <other useful comments, qualifications, etc.>
#
#    MODIFIED   (MM/DD/YY)
#    davjimen    01/19/17 - add common libraries for the perl command
#    pkuruvad    07/13/16 - Disable auto-expansion
#    pkuruvad    11/20/15 - Creation

# disabling automatic wildcard expansion, without this $* will get expanded
set -f;

ORACLE_HOME="";

DIRNAME="/usr/bin/dirname";
UNAME="/bin/uname";
DIRLOC="`${DIRNAME} $0`";
if [ "`${UNAME}`" = "SunOS" ] && [ "`${UNAME} -r`" = "5.10" ]; then
  SYMLINKSFOUND="false";
  AUXDIRLOC="${DIRLOC}";
  while [ "${AUXDIRLOC}" != "." ] && [ "${AUXDIRLOC}" != "/" ]; do
    if [ -L "${AUXDIRLOC}" ]; then
      SYMLINKSFOUND="true";
      break;
    fi
    AUXDIRLOC="`${DIRNAME} ${AUXDIRLOC}`";
  done
  
  if [ "${SYMLINKSFOUND}" = "true" ]; then
    case "${DIRLOC}" in
      /*)
        ORACLE_HOME="`${DIRNAME} ${DIRLOC}`";
      ;;
      *)
        CURRENTDIR="`pwd`";
        AUXDIRLOC="${CURRENTDIR}/${DIRLOC}";
        ORACLE_HOME="`${DIRNAME} ${AUXDIRLOC}`";
      ;;
    esac
  else
    cd "${DIRLOC}/..";
    ORACLE_HOME="`pwd -L`";
  fi
else
  cd "${DIRLOC}/..";
  ORACLE_HOME="`pwd -L`";
fi

export ORACLE_HOME;

# Execute the common setup code
. ${ORACLE_HOME}/bin/commonSetup.sh $*

#unset module;

${ORACLE_HOME}/perl/bin/perl -I${ORACLE_HOME}/perl/lib -I${ORACLE_HOME}/bin ${ORACLE_HOME}/addnode/addnode.pl $*
exit $?;
