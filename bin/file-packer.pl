#!/usr/bin/perl
use strict;
use warnings;
use File::Packer;

my $packer = File::Packer->new( dir => "./" );
$packer->make_starter( $ARGV[0] );

__END__

=head1 SYNOPSIS

  $ file-packer.pl --template MyApp --output Hoge::Starter
