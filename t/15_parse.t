use strict;
use Test::More;
use File::Packer::Starter;

my $starter = File::Packer::Starter->new( module => 'MyApp' );
my $content = << "EOF";
[___ name -___]
EOF
my $out = $starter->process_tt($content);
is($out,'MyApp','Template output is ok');
done_testing;
