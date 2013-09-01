package WebService::BasecampX;

use strict;
use 5.008_005;
our $VERSION = '0.01';

use Net::HTTP::Spore;
use Carp;

sub new {
    my ( $class, %args ) = @_;

    my $self = bless( {}, $class );

    my $spec = <<'EOS';
    {
    "name": "basecamp",
    "version":"1",
    "authentication" : true,
    "methods":{
      "projects":{
        "path":"/projects.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "archived_projects":{
        "expected_status":["200"],
        "path":"/projects/archived.json",
        "method":"GET"
      },
      "project":{
        "expected_status":["200"],
        "path":"/projects/:project.json",
        "method":"GET",
        "required_params" : [
           "project"
        ]
      },
      "todolists":{
        "expected_status":["200"],
        "path":"/todolists.json",
        "method":"GET"
      },
      "todolist":{
        "expected_status":["200"],
        "path":"/projects/:project/todolists/:todolist.json",
        "method":"GET",
        "required_params" : [
           "project",
           "todolist"
        ]
      },
      "project_todolists":{
        "expected_status":["200"],
        "path":"/projects/:project/todolists.json",
        "method":"GET",
        "required_params" : [
           "project"
        ]
      }
    }
    }

EOS
    $self->{_client} = Net::HTTP::Spore->new_from_string( $spec,
              base_url => 'https://basecamp.com/'
            . $args{account_id}
            . '/api/v1/' );
    $self->{_client}->enable('Format::JSON');
    $self->{_client}->enable(
        'Auth::Basic',
        username => $args{username},
        password => $args{password} );
    return $self;
}

our $AUTOLOAD;

sub AUTOLOAD {
    my $self = shift;
    ref($self) || die "$self is not an object";
    my $method = $AUTOLOAD;
    $method =~ s/.*://;
    die "Can't call $method()"
        unless grep { $_ eq $method }
        @{ $self->{_client}->meta->local_spore_methods };
    return $self->{_client}->$method(@_)->body;
}

1;
__END__

=encoding utf-8

=head1 STATUS NOTE

This module is incomplete.  It's not very useful yet.

=head1 NAME

WebService::BasecampX - Perl interface to the bcx Basecamp API

=head1 SYNOPSIS

  use WebService::BasecampX;

=head1 DESCRIPTION

WebService::BasecampX is a client implentation for the bcx Basecamp API

=head1 AUTHOR

Mike Greb E<lt>michael@thegrebs.comE<gt>

=head1 COPYRIGHT

Copyright 2013- Mike Greb

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
