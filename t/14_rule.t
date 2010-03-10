use strict;
use Test::More;

use_ok('File::Packer::Rule');
my $module = "MyApp";
my $r = File::Packer::Rule->new( module => $module );
my $rule = $r->_rule;
ok( $rule->{$module} );
use YAML;
diag Dump $rule;
done_testing;
