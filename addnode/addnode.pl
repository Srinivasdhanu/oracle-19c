#!../perl/bin/perl
# $Header: install/utl/scripts/db/addnode/addnode.pl /main/11 2020/07/29 03:33:08 pkuruvad Exp $
#
# addnode.pl
# 
# Copyright (c) 2015, 2020, Oracle and/or its affiliates. 
#
#    NAME
#      addnode.pl - <one-line expansion of the name>
#
#    DESCRIPTION
#      <short description of component this file declares/defines>
#
#    NOTES
#      <other useful comments, qualifications, etc.>
#
#    MODIFIED   (MM/DD/YY)
#    pkuruvad    07/21/20 - RTI 22847161 - set scratchpath outside OH
#    davjimen    06/26/17 - bug 26351914 - implement method to calculate the
#                           temp log directory
#    davjimen    01/19/17 - remove common code
#    ambagraw    10/20/16 - Bug 24654752: Unsetting ORA_CRS_HOME Environment
#                           variable
#    davjimen    08/05/16 - support jreloc flag
#    davjimen    06/15/16 - remove the newly created files from the scratch
#                           path location
#    pkuruvad    11/20/15 - Creation
#
use strict;
use warnings;
package Addnode;

use parent qw(CommonSetup);

sub new {
  my ($class) = @_;

  my $self = $class->SUPER::new(
    "TYPE" => "Common",
    "PRODUCT_DESCRIPTION" => "Oracle software",
    "PRODUCT_JAR_NAME" => "instcommon.jar",
    "SETUP_SCRIPTS" => "addnode.sh,addnode.bat",
    "LOG_DIR_PREFIX" => "AddnodeActions",
    "MAIN_CLASS" => "oracle.install.ivw.common.util.OracleNodeScaler",
  );
  bless $self, $class;
  return $self;
}

my $addnode = new Addnode();

$addnode->main();

sub checkPatchActions() {
	# Nothing to do here
}

sub changeDestinationHome() {
	# Nothing to do here
}

sub rootPreCheck() {
	# Nothing to do here
}

sub calculateTempLogDir() {
	# Set the temporary log directoy location directly to the temp location
	# For addnode, there is no container directory created for the logs.
	my $self = shift;
	return $self->SUPER::calculateTempLoc();
}

sub createTempDirectory() {
	# Nothing to do here
}

sub calculateScratchPath() {
	# For addnode, set /tmp/<AddNodeActions>/<Timestamp>/<scratch>
	# as the scratchpath
	my $self = shift;
        my $tmpLoc = $self->calculateTempLogDir();
        my $dirSep = $self->SUPER::getDirSep();
        my $timestamp = $self->SUPER::calculateTimestamp();
        my $scratchPathSuffix = "scratch";
        my $scratchPath = $tmpLoc.$dirSep.$self->{"LOG_DIR_PREFIX"}.$timestamp.$dirSep.$scratchPathSuffix;
        #print "Scratch Path is : $scratchPath\n";
        return $scratchPath;
}
