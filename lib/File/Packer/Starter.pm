package File::Packer::Starter;
use strict;
use warnings;
use File::Packer::Unpack;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless { class => $class }, $class;
    $self;
}

sub run {
    my $self = shift;
    my $data = "$self->{class}::DATA";
    my $template = join '', <$data>;
    my $unpacker = File::Packer::Unpack->new;
    $unpacker->unpack( $template );
}

1;
