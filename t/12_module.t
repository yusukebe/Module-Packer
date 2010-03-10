use strict;
use Test::More;

use_ok('File::Packer');

my $packer = File::Packer->new( dir => "t/MyApp", template_module => 'MyApp' );
ok($packer);
$packer->make_starter( { starter => 'MyApp::Starter' }, 'debug' );  #do not run!

done_testing;
