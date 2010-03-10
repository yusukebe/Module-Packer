package File::Packer::Starter;
use strict;
use warnings;
use File::Packer::Unpack;
use Template;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless { class => $class }, $class;
    $self;
}

sub run {
    my $self = shift;
    $self->{module} = $ARGV[0];
    my $data = "$self->{class}::DATA";
    my $yaml = join '', <$data>;
    $yaml = $self->process_tt( $yaml );
    my $unpacker = File::Packer::Unpack->new;
    $unpacker->unpack( $yaml );
}

sub process_tt {
    my ( $self, $content ) = @_;
    my $tt = Template->new(
        {
            START_TAG => '___',
            END_TAG   => '___',
        }
    );
    my $output;
    $tt->process(\$content, $self->vars, \$output );
    return $output;
}

sub vars {
    my $self = shift;
    my @path = split '::', $self->{class};
    my $file = pop @path;
    return { name => $self->{class}, file => "$file.pm" };
}

1;
