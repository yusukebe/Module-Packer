package File::Packer;
use strict;
use warnings;
our $VERSION = '0.01';
use File::Spec;
use IO::File;
use Path::Class qw( dir file );
use YAML qw( Dump );

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless {
        dir => dir( $opt{dir} || '/' ),
        max_recursive => 50,    #XXX
        data => '',
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
            $self->add_data( $c );
        }else{
            $self->slurp_dir( $c );
        }
    }
}

sub add_data {
    my ( $self, $file ) = @_;
    my $data;
    $data->{file} = $self->file_path( $file );
    for ( $file->slurp ){
        $data->{template} .= "$_";
    }
    $self->{data} .= Dump( $data );
}

sub file_path {
    my ( $self, $file ) = @_;
    my $dir_path = $self->{dir}->stringify;
    if( $file->stringify =~ /$dir_path\/?(.+)/ ){
        return $1
    }else{
        return $file->stringify;
    }
}

sub make_starter {
    my ( $self, $class ) = @_;
    my $data = $self->pack;
    my $template = <<"EOF";
package $class;
use strict;
use warnings;
use File::Packer::Unpack;

__DATA__

$data
EOF
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

File::Packer - "Pack" files in directory as text data to one module for starter script.

=head1 SYNOPSIS

  use File::Packer;

=head1 DESCRIPTION

File::Packer is

=head1 AUTHOR

Yusuke Wada E<lt>yusuke at kamawada.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
