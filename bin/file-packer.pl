#!/usr/bin/perl
use strict;
use warnings;
use File::Packer;
use Getopt::Long;

my %opt;
GetOptions( "template=s" => \$opt{template}, "starter=s" => \$opt{starter} );
my $packer = File::Packer->new( dir => "./" );
$packer->make_starter( \%opt );

__END__

=head1 SYNOPSIS

  $ file-packer.pl --template MyApp --starter Hoge::Starter

