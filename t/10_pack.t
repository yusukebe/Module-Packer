use strict;
use Test::More;

use_ok('File::Packer');
my $packer = File::Packer->new( dir => "t/MyApp" );
my $data = $packer->pack( {} );
ok( $data );
done_testing;
