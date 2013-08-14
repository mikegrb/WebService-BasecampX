package WebService::BasecampX;

use strict;
use 5.008_005;
our $VERSION = '0.01';

use Mojo::UserAgent;
use Carp;

sub new {
    my ( $class, %args ) = @_;

    my $self = bless( {}, $class );

    $self->{ua}  = Mojo::UserAgent->new;
    $self->{url} = Mojo::URL->new(
        'https://basecamp.com/' . $args{account_id} . '/api/v1/' );

    $self->{ua}->name('Perl WebService::BasecampX (mgreb@linode.com)');
    $self->{url}->userinfo( $args{username} . ':' . $args{password} );

    return $self;
}

sub _get {
    my ( $self, $path ) = @_;
    my $url = $self->{url} . $path;
    my $tx  = $self->{ua}->get($url);
    if ( my $res = $tx->success ) {
        return $res->json;
    }
    else {
        my ( $error, $code ) = $tx->error;
        croak $code ? "Error $code: $error" : "Connection error: $error";
    }
}

sub projects {
    my $self = shift;
    return $self->_get('projects.json');
}

# TODO for a person too
sub todolists {
    my ( $self, $project_id ) = @_;
    my $url = ( $project_id ? "projects/$project_id/" : '' ) . 'todolists.json';
    return $self->_get($url);
}

# TODO for a person too
sub todos {
    croak "todos requires project id and todolist as arguments" unless @_ == 3;
    my ( $self, $project_id, $todolist_id ) = @_;
    return $self->_get("/projects/$project_id/todolists/$todolist_id.json");
}

1;
__END__

=encoding utf-8

=head1 NAME

WebService::BasecampX - Perl interface to the bcx Basecamp API

=head1 SYNOPSIS

  use WebService::BasecampX;

=head1 DESCRIPTION

WebService::BasecampX is

=head1 AUTHOR

Mike Greb E<lt>michael@thegrebs.comE<gt>

=head1 COPYRIGHT

Copyright 2013- Mike Greb

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
