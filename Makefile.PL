use inc::Module::Install;
name 'File-Packer';
all_from 'lib/File/Packer.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
