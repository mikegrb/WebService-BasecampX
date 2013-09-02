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
        "path":"/projects/archived.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "project":{
        "path":"/projects/:project.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project"
        ]
      },
      "todolists":{
        "path":"/todolists.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "project_todolists":{
        "path":"/projects/:project/todolists.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project"
        ]
      },
      "todolist":{
        "path":"/projects/:project/todolists/:todolist.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project",
           "todolist"
        ]
      },
      "todo":{
        "path":"/projects/:project/todos/:todo.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project",
           "todo"
        ]
      },
      "events":{
        "path":"/events.json",
        "expected_status":["200"],
        "method":"GET",
        "optional_params" : [
           "since",
           "page"
        ]
      },
      "topics":{
        "path":"/projects/:project/topics.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project"
        ],
        "optional_params" : [
            "page"
        ]
      },
      "people":{
        "path":"/people.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "person":{
        "path":"/people/:person.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
            "person"
        ] 
      },
      "me":{
        "path":"/people/me.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "message":{
        "path":"/projects/:project/messages/:message.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
            "project",
            "message"
        ] 
      }, 
      "documents":{
        "path":"/documents.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "project_documents":{
        "path":"/projects/:project/documents.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project"
        ]
      },
      "document":{
        "path":"/projects/:project/documents/:document.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project",
           "document"
        ]
      },
      "attachments":{
        "path":"/attachments.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "project_attachments":{
        "path":"/projects/:project/attachments.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project"
        ]
      },
      "upload":{
        "path":"/projects/:project/uploads/:upload.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
           "project",
           "upload"
        ]
      },
      "calendars":{
        "path":"/calendars.json",
        "expected_status":["200"],
        "method":"GET"
      },
      "calendar":{
        "path":"/calendars/:calendar.json",
        "expected_status":["200"],
        "method":"GET",
        "required_params" : [
          "calendar"
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
