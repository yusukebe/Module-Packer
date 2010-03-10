#!/usr/bin/perl
use strict;
use warnings;
use Module::Packer;
use Getopt::Long;

my %opt;
GetOptions( "template=s" => \$opt{template}, "starter=s" => \$opt{starter} );
my $packer = Module::Packer->new( dir => "./" );
$packer->make_starter( \%opt );

__END__

=head1 SYNOPSIS

  $ module-packer.pl --template MyApp --starter Foo::Starter

