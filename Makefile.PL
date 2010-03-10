use inc::Module::Install;
name 'Module-Packer';
all_from 'lib/Module/Packer.pm';

requires 'File::Spec';
requires 'IO::File';
requires 'Path::Class';
requires 'YAML';
requires 'Template';
requires 'Getopt::Long';

install_script 'bin/module-packer.pl';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
