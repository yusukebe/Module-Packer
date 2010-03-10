use strict;
use Test::More;
use Path::Class qw( file );

use_ok('File::Packer::Unpack');
my $unpacker = File::Packer::Unpack->new( dir => 't/temp' );
ok( $unpacker );
# $unpacker->unpack( join '', file('t/myapp.txt')->slurp ); do not run!

done_testing;
