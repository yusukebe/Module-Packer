package Module::Packer;
use strict;
use warnings;
our $VERSION = '0.01';
use File::Spec;
use IO::File;
use Path::Class qw( dir file );
use YAML qw( Dump );
use Module::Packer::Rule;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless {
        dir => dir( $opt{dir} || '/' ),
        max_recursive => 50,    #XXX
        data => '',
        template_module => $opt{template_module} || '', #XXX
    }, $class;
    $self;
}

sub pack {
    my ($self, $params) = @_;
    my $dir = $self->{dir};
    $self->slurp_dir( $dir );
    return $self->{data};
}

sub slurp_dir {
    my ( $self, $dir ) = @_;
    for my $c ( $dir->children ){
        if( -f $c->stringify ){
            next if $c->basename eq 'Starter.pm';
            $self->add_data( $c );
        }else{
            $self->slurp_dir( $c );
        }
    }
}

sub add_data {
    my ( $self, $file ) = @_;
    my $data;
    $data->{file} = $self->apply_rule( $self->file_path( $file ) );
    for ( $file->slurp ){
        $data->{template} .= $self->apply_rule( $_ );
    }
    $self->{data} .= Dump( $data );
}

sub apply_rule {
    my ( $self, $str ) = @_;
    return $self->{rule}->replace( $str ) if $self->{rule};
    return $str;
}

sub file_path {
    my ( $self, $file ) = @_;
    my $dir_path = $self->{dir}->stringify ne '.' ? $self->{dir}->stringify : '';
    if( $file->stringify =~ /$dir_path\/?(.+)/ ){
        return $1
    }else{
        return $file->stringify;
    }
}

sub make_starter {
    my ( $self, $opt, $debug ) = @_;
    my $class = $opt->{starter};
    $self->{template_module} ||= $opt->{template};
    $self->{rule} = Module::Packer::Rule->new( module => $self->{template_module} );
    my $data = $self->pack;
    my $template = <<"EOF";
package $class;
use base 'Module::Packer::Starter';
use strict;
use warnings;

1;

__DATA__

$data
EOF
    if( $debug ){
        print $template;
        return;
    }
    my @path = split "::", $class;
    my $name = pop @path;
    $name .= '.pm';
    my $fh = IO::File->new( $name, "w" );
    if( defined $fh ){
        warn "Writing $name\n";
        print $fh $template;
        $fh->close;
    }
}

1;

__END__

=head1 NAME

Module::Packer - Make starter class from template module and unpack as different module.

=head1 SYNOPSIS

  $ module-packer --template MyApp --starter Foo::Starter

  #or using class
  use Module::Packer;
  my $packer = Module::Packer->new( dir => "./" );
  $packer->make_starter( { template => 'MyApp', starter => 'Foo::Starter' } );

  # generate Starter.pm


  # if starter class is generated
  # in your starter script
  use Foo::Starter;
  my $starter = Foo::Starter->new;
  $starter->run;
  # if ARGV[0] is Bar, Bar class and other files like MyApp are genrated


=head1 DESCRIPTION

Module::Packer is simple script and classes for making starter script.
This module make starter class from template module and unpack as different module.

=head1 AUTHOR

Yusuke Wada E<lt>yusuke at kamawada.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
