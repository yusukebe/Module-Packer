use strict;
use Test::More;

use_ok('Module::Packer::Rule');
my $module = "MyApp";
my $r = Module::Packer::Rule->new( module => $module );
my $rule = $r->_rule;
ok( $rule->{$module} );
use YAML;
diag Dump $rule;
done_testing;
