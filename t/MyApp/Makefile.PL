use inc::Module::Install;
name 'MyApp';
all_from 'lib/MyApp.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
