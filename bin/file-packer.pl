#!/usr/bin/perl
use strict;
use warnings;
use File::Packer;

my $packer = File::Packer->new( dir => "./" );
$packer->make_starter( $ARGV[0] );
