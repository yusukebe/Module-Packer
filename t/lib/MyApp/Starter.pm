package MyApp::Starter;
use base 'File::Packer::Starter';
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
---
file: Changes
template: |
  Revision history for Perl extension MyApp
  
  0.01    Wed Mar 10 21:42:53 2010
          - original version
---
file: MANIFEST.SKIP
template: |
  \bRCS\b
  \bCVS\b
  ^MANIFEST\.
  ^Makefile$
  ~$
  ^#
  \.old$
  ^blib/
  ^pm_to_blib
  ^MakeMaker-\d
  \.gz$
  \.cvsignore
  ^t/9\d_.*\.t
  ^t/perlcritic
  ^tools/
  \.svn/
  ^[^/]+\.yaml$
  ^[^/]+\.pl$
  ^\.shipit$
  ^\.git/
  \.sw[po]$
---
file: README
template: |
  This is Perl module MyApp.
  
  INSTALLATION
  
  MyApp installation is straightforward. If your CPAN shell is set up,
  you should just be able to do
  
      % cpan MyApp
  
  Download it, unpack it, then build it as per the usual:
  
      % perl Makefile.PL
      % make && make test
  
  Then install it:
  
      % make install
  
  DOCUMENTATION
  
  MyApp documentation is available as in POD. So you can do:
  
      % perldoc MyApp
  
  to read the documentation online with your favorite pager.
  
  Yusuke Wada
---
file: .shipit
template: "steps = FindVersion, ChangeVersion, CheckChangeLog, DistTest, Commit, Tag, MakeDist, UploadCPAN\n"
---
file: lib/MyApp.pm
template: |
  package MyApp;
  use strict;
  use warnings;
  our $VERSION = '0.01';
  
  1;
  __END__
  
  =head1 NAME
  
  MyApp -
  
  =head1 SYNOPSIS
  
    use MyApp;
  
  =head1 DESCRIPTION
  
  MyApp is
  
  =head1 AUTHOR
  
  Yusuke Wada E<lt>yusuke at kamawada.comE<gt>
  
  =head1 SEE ALSO
  
  =head1 LICENSE
  
  This library is free software; you can redistribute it and/or modify
  it under the same terms as Perl itself.
  
  =cut
---
file: .gitignore
template: |
  cover_db
  META.yml
  Makefile
  blib
  inc
  pm_to_blib
  MANIFEST
  Makefile.old
  nytprof.out
  MANIFEST.bak
  *.sw[po]

