#!/usr/bin/perl
use strict;
use warnings;
use Module::Packer;
use Getopt::Long;
use Pod::Usage;

my %opt;
GetOptions( "template=s" => \$opt{template}, "starter=s" => \$opt{starter} );
unless ( $opt{template} && $opt{starter} ){
    pod2usage(0);
}
my $packer = Module::Packer->new( dir => "./" );
$packer->make_starter( \%opt );

__END__

=head1 SYNOPSIS

  $ module-packer.pl --template MyApp --starter Foo::Starter

