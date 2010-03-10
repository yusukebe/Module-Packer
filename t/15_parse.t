use strict;
use Test::More;
use Module::Packer::Starter;

my $starter = Module::Packer::Starter->new( module => 'MyApp' );
my $content = << "EOF";
[___ name -___]
[___ USE String(name.replace('::','_')); String.lower -___]
EOF
my $out = $starter->process_tt($content);
is($out,'MyAppmyapp','Template output is ok');
done_testing;
