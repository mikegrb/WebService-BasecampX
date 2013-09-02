# STATUS NOTE

This module is incomplete.  It's not very useful yet.

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
    }

# DESCRIPTION

WebService::BasecampX is a client implentation for the bcx Basecamp API

# AUTHOR

Mike Greb <michael@thegrebs.com>

# COPYRIGHT

Copyright 2013- Mike Greb

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
