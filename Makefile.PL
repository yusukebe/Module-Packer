use inc::Module::Install;
name 'File::Packer';
all_from 'lib/File/Packer.pm';

# requires '';

install_script 'bin/file-packer.pl';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
