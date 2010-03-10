package MyApp::Starter;
use base 'Module::Packer::Starter';
use strict;
use warnings;

1;

__DATA__

---
file: Makefile.PL
template: |
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

