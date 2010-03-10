package Module::Packer::Starter;
use strict;
use warnings;
use Module::Packer::Unpack;
use Template;

sub new {
    my ( $class, %opt ) = @_;
    my $module = $opt{module} || $ARGV[0] || '';
    $module =~ s/\/$//;
    my $self = bless { class => $class, module => $module },
      $class;
    $self;
}

sub run {
    my $self = shift;
    unless( $self->{module} ){
        die "New module name argument is required\n";
    }
    my $data = "$self->{class}::DATA";
    my $yaml = join '', <$data>;
    $yaml = $self->process_tt( $yaml );
    my $unpacker = Module::Packer::Unpack->new;
    $unpacker->unpack( $yaml );
}

sub process_tt {
    my ( $self, $content ) = @_;
    my $tt = Template->new(
        {
            START_TAG => quotemeta('[___'),
            END_TAG   => quotemeta('___]'),
        }
    );
    my $output;
    $tt->process(\$content, $self->vars, \$output );
    return $output;
}

sub vars {
    my $self = shift;
    my @path = split '::', $self->{module};
    my $file = pop @path;
    return { name => $self->{module}, file => "$file.pm" };
}

1;
