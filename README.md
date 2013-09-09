# NAME

WebService::BasecampX - Perl interface to the bcx Basecamp API

# SYNOPSIS

    use WebService::BasecampX;
    my $bc = WebService::BasecampX->new(
        username   => $user,
        password   => $pass,
        account_id => $account
    );
    for my $project ( @{ $bc->projects } ) {
        say join( "\t", $project->{last_event_at}, $project->{name} );
        my $todo_lists = $bc->project_todolists( project => $project->{id} );
        # do something with $todo_lists
    }

# DESCRIPTION

WebService::BasecampX is a client implentation for the bcx Basecamp API

This module currently only supports the GET methods on the Basecamp API but
provides 100% coverage for them.  Thus, it provides full read-only access to
the Basecamp API.  Creating and modifying things is coming in a future release
when I get enough tuits.

Optional and required arguments for the various methods are expected as named
arguments to the method.  See the synopsis call to `project_todolists` for
example usage.

# METHODS

## attachments

Show attatchments for all projects.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/attachments.md)

## calendar

Returns the specified calendar.

Required arguments: `calendar`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## calendar\_accesses

Returns all the people with access to the calendar

Required arguments: `calendar`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/accesses.md)

## calendar\_event

Returns specified calnedar event.

Required arguments: `calendar`, `event`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## calendar\_events

Returns upcoming calendar events for the given calendar.

Required arguments: `calendar`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## calendar\_events\_past

Returns past calendar events for the given calendar.

Required arguments: `calendar`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## calendars

Returns all calendars, sorted alphabetically.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## document

Returns specified document with all comments.

Required arguments: `project`, `document`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/documents.md)

## documents

Shows documents for all projects.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/documents.md)

## events

Returns all events on the account, 50 per page

Optional arguments: `since`, `page`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/events.md)

## message

Return a specified message

Required arguments: `project`, `message`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/messages.md)

## people

Returns all people on the account.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/people.md)

## person

Returns a specified person.

Required arguments: `person`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/people.md)

## person\_me

Returns the current person.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/people.md)

## person\_todolists

Returns all todolists with todos assigned to the specified person.

Required arguments: `person`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/todolists.md)

## project

Retrieve data for specified project.

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/projects.md)

## project\_accesses

Returns all the people with access to the project

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/accesses.md)

## project\_attachments

Show attatchments for given project.

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/attachments.md)

## project\_calendar\_event

Returns specified calnedar event.

Required arguments: `project`, `event`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## project\_calendar\_events

Returns upcoming calendar events for the project.

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## project\_calendar\_events\_past

Returns past calendar events for the project.

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/calendars.md)

## project\_documents

Shows documents for specified project, alphabetically by title.

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/documents.md)

## project\_todolists

Shows active todolists for given project, sorted by position.

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/todolists.md)

## project\_todolists\_completed

Shows completed todolists for given project.

Required arguments: `project`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/todolists.md)

## project\_topics

Returns topics for given project, 50 per page.

Required arguments: `project`

Optional arguments: `page`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/topics.md)

## projects

Retrieve data for all projects user has access to.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/projects.md)

## projects\_archived

Retrieve data for all archived projects user has access to.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/projects.md)

## todo

Returns the specified todo.

Required arguments: `project`, `todo`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/todos.md)

## todolist

Returns the specified todolist, including the todos.

Required arguments: `project`, `todolist`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/todolists.md)

## todolists

Show all active todolists for all projects.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/todolists.md)

## todolists\_completed

Show completed todolists for all projects.

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/todolists.md)

## topics

Returns all topics for the account, 50 per page.

Optional arguments: `page`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/topics.md)

## upload

Returns the content, comments, and attatchments for specified upload.

Required arguments: `project`, `upload`

[See the Basecamp API docs for this method for more information or a sample of returned data.](https://github.com/37signals/bcx-api/blob/master/sections/uploads.md)

# AUTHOR

Mike Greb <michael@thegrebs.com>

# COPYRIGHT

Copyright 2013- Mike Greb

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Basecamp API Docs](https://github.com/37signals/bcx-api)
