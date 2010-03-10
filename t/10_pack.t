use strict;
use Test::More;

use_ok('Module::Packer');
my $packer = Module::Packer->new( dir => "t/MyApp" );
my $data = $packer->pack;
ok( $data );
done_testing;
