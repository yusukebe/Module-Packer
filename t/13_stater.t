use strict;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/lib";
use MyApp::Starter;

my $starter = MyApp::Starter->new;
ok( $starter );
#$starter->run; do not run!

done_testing;
