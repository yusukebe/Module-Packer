package File::Packer::Rule;
use strict;
use warnings;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless { module => $opt{module}, }, $class;
    $self;
}

sub replace {
    my ($self, $str) = @_;
    my $rule = $self->_rule;
    for my $key ( keys %$rule ){
        $str =~ s/$key/$rule->{$key}/g if $key;
    }
    return $str;
}

sub _rule {
    my $self = shift;
    my $module = $self->{module};
    my $module_h = $module;
    $module_h =~ s/::/-/g;
    my $module_name = $module;
    $module_name =~ s/::/_/g;
    $module_name = lc $module_name;
    my @path    = split "::", $self->{module};
    my $name    = pop @path;
    $name .= ".pm";
    return {
        $module        => "___name___",
        $module_h      => "___name.replace('::','-')___",
        $module_name   => "___name.replace('::','_').lower___",
        $name       => "___file___",
    };
}

1;
