package Module::Packer::Unpack;
use strict;
use warnings;
use File::Spec;
use Path::Class qw( dir file );
use IO::File;
use YAML qw( Load );

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless { dir => dir( $opt{dir} || './' ), }, $class;
    $self;
}

sub unpack {
    my ( $self, $data ) = @_;
    my $entries = $self->parse( $data );
    $self->generate( $entries );
}

sub generate {
    my ( $self, $entries ) = @_;
    for my $entry ( @$entries ){
        my $filepath = File::Spec->catfile( $self->{dir}, $entry->{file} );
        my ( $v , $dir ) = File::Spec->splitpath( $filepath );
        dir( $dir )->mkpath;
        my $fh = IO::File->new( $filepath, "w");
        if( defined $fh ){
            warn "Writing $filepath\n";
            print $fh $entry->{template};
            $fh->close;
        }
    }
}

sub parse {
    my ( $self, $data ) = @_;
    my ( $entry, $entries );
    for my $line ( split "\n", $data ) {
        if ( $line =~ /^---$/ ) {
            if ( $entry ){
                $entry .= "\n";
                push @$entries, Load($entry);
                $entry = '';
            }
        }
        else {
            $entry .= "$line\n";
        }
    }
    return $entries;
}

1;

__END__

=head1 NAME

Module::Packer::Unpack - 

=head1 SYNOPSIS

  use Module::Packer::Unpack;

=head1 DESCRIPTION

Module::Packer::Unpack is

=head1 AUTHOR

Yusuke Wada E<lt>yusuke at kamawada.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
