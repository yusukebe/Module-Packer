use strict;
use Test::More;

use_ok('File::Packer');

my $packer = File::Packer->new( dir => "t/MyApp" );
ok( $packer );
#$packer->make_starter('MyApp::Starter'); do not run!

done_testing;
