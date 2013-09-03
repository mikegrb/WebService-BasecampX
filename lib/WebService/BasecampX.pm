package WebService::BasecampX;

use strict;
use 5.008_005;
our $VERSION = '0.01';

use Net::HTTP::Spore;
use Carp;

sub new {
    my ( $class, %args ) = @_;

    my $self = bless( {}, $class );

    my $spec = join '', <DATA>;
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

=encoding utf-8

=head1 STATUS NOTE

This module is incomplete.  It's not very useful yet.

=head1 NAME

WebService::BasecampX - Perl interface to the bcx Basecamp API

=head1 SYNOPSIS

  use WebService::BasecampX;
  my $bc = WebService::BasecampX->new(
      username   => $user,
      password   => $pass,
      account_id => $account
  );
  for my $project ( @{ $bc->projects } ) {
      say join( "\t", $project->{last_event_at}, $project->{name} );
  }

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
__DATA__
{
  "name": "basecamp",
  "version":"0.1",
  "authority" : "GITHUB:mikegrb",
  "meta" : {
     "documentation" : "https://github.com/37signals/bcx-api"
  },
  "authentication" : true,
  "formats" : [ 
    "json"
  ],
  "methods":{
    "projects":{
      "path":"/projects.json",
      "method":"GET",
      "description":"Retrieve data for all projects user has access to.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/projects.md"
    },
    "archived_projects":{
      "path":"/projects/archived.json",
      "method":"GET",
      "description":"Retrieve data for all archived projects user has access to.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/projects.md"
    },
    "project":{
      "path":"/projects/:project.json",
      "method":"GET",
      "description":"Retrieve data for specified project.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/projects.md",
      "required_params":[ "project" ]
    },
    "people":{
      "path":"/people.json",
      "method":"GET",
      "description":"Returns all people on the account.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/people.md"
    },
    "person":{
      "path":"/people/:person.json",
      "method":"GET",
      "description":"Returns a specified person.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/people.md",
      "required_params":["person"] 
    },
    "me":{
      "path":"/people/me.json",
      "method":"GET",
      "description":"Returns the current person.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/people.md"
    },
    "project_accesses":{
      "path":"/projects/:project/accesses.json",
      "method":"GET",
      "description":"Returns all the people with access to the project",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/accesses.md",
      "required_params":[ "project" ]
    },
    "calendar_accesses":{
      "path":"/calendars/:calendar/accesses.json",
      "method":"GET",
      "description":"Returns all the people with access to the calendar",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/accesses.md",
      "required_params":[ "calendar" ]
    },
    "events":{
      "path":"/events.json",
      "method":"GET",
      "description":"Returns all events on the account, 50 per page",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/events.md",
      "optional_params":[ "since", "page" ]
    },
    "topics":{
      "path":"/topics.json",
      "method":"GET",
      "description":"Returns all topics for the account, 50 per page.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/topics.md", 
      "optional_params":[ "page" ]
    },
    "project_topics":{
      "path":"/projects/:project/topics.json",
      "method":"GET",
      "description":"Returns topics for given project, 50 per page.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/topics.md", 
      "required_params":[ "project" ],
      "optional_params":[ "page" ]
    },
    "message":{
      "path":"/projects/:project/messages/:message.json",
      "method":"GET",
      "description":"Return a specified message",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/messages.md",
      "required_params":[ "project", "message" ] 
    }, 
    "todolists":{
      "path":"/todolists.json",
      "method":"GET",
      "description":"Show all active todolists for all projects.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/todolists.md"
    },
    "todolists_completed":{
      "path":"/todolists/completed.json",
      "method":"GET",
      "description":"Show completed todolists for all projects.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/todolists.md"
    },
    "project_todolists":{
      "path":"/projects/:project/todolists.json",
      "method":"GET",
      "description":"Shows active todolists for given project, sorted by position.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/todolists.md",
      "required_params":[ "project" ]
    },
    "project_todolists_completed":{
      "path":"/projects/:project/todolists/completed.json",
      "method":"GET",
      "description":"Shows completed todolists for given project.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/todolists.md",
      "required_params":[ "project" ]
    },
    "person_todolists":{
      "path":"/people/:person/assigned_todos.json",
      "method":"GET",
      "description":"Returns all todolists with todos assigned to the specified person.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/todolists.md",
      "required_params":[ "person" ]
    },
    "todolist":{
      "path":"/projects/:project/todolists/:todolist.json",
      "method":"GET",
      "description":"Returns the specified todolist, including the todos.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/todolists.md",
      "required_params":[ "project", "todolist" ]
    },
    "todo":{
      "path":"/projects/:project/todos/:todo.json",
      "method":"GET",
      "description":"Returns the specified todo.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/todos.md",
      "required_params":[ "project", "todo" ]
    },
    "documents":{
      "path":"/documents.json",
      "method":"GET",
      "description":"Shows documents for all projects.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/documents.md"
    },
    "project_documents":{
      "path":"/projects/:project/documents.json",
      "method":"GET",
      "description":"Shows documents for specified project, alphabetically by title.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/documents.md",
      "required_params": [ "project" ]
    },
    "document":{
      "path":"/projects/:project/documents/:document.json",
      "method":"GET",
      "description":"Returns specified document with all comments.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/documents.md",
      "required_params": [ "project", "document" ]
    },
    "attachments":{
      "path":"/attachments.json",
      "description":"Show attatchments for all projects.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/attachments.md",
      "method":"GET"
    },
    "project_attachments":{
      "path":"/projects/:project/attachments.json",
      "method":"GET",
      "description":"Show attatchments for given project.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/attachments.md",
      "required_params": [ "project" ]
    },
    "upload":{
      "path":"/projects/:project/uploads/:upload.json",
      "method":"GET",
      "description":"Returns the content, comments, and attatchments for specified upload.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/uploads.md",
      "required_params": [ "project", "upload" ]
    },
    "calendars":{
      "path":"/calendars.json",
      "method":"GET",
      "description":"Returns all calendars, sorted alphabetically.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md"
    },
    "calendar":{
      "path":"/calendars/:calendar.json",
      "method":"GET",
      "description":"Returns the specified calendar.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md",
      "required_params": [ "calendar" ]
    },
    "calendar_events":{
      "path":"/calendars/:calendar/calendar_events.json",
      "method":"GET",
      "description":"Returns upcoming calendar events for the given calendar.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md",
      "required_params": [ "calendar" ]
    },
    "project_calendar_events":{
      "path":"/projects/:project/calendar_events.json",
      "method":"GET",
      "description":"Returns upcoming calendar events for the project.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md",
      "required_params": [ "project" ]
    },
    "calendar_events_past":{
      "path":"/calendars/:calendar/calendar_events/past.json",
      "method":"GET",
      "description":"Returns past calendar events for the given calendar.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md",
      "required_params": [ "calendar" ]
    },
    "project_calendar_events_past":{
      "path":"/projects/:project/calendar_events/past.json",
      "method":"GET",
      "description":"Returns past calendar events for the project.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md",
      "required_params": [ "project" ]
    },
    "calendar_event":{
      "path":"/calendars/:calendar/calendar_events/:event.json",
      "method":"GET",
      "description":"Returns specified calnedar event.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md",
      "required_params": [ "calendar", "event" ]
    },
    "project_calendar_event":{
      "path":"/projects/:project/calendar_events/:event.json",
      "method":"GET",
      "description":"Returns specified calnedar event.",
      "documentation":"https://github.com/37signals/bcx-api/blob/master/sections/calendars.md",
      "required_params": [ "project", "event" ]
    }
  }
}
