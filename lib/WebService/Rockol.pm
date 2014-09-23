package WebService::Rockol;
use JSON::XS;
use Cache::LRU;
use Net::DNS::Lite;
use Furl;
use URI;
use URI::QueryParam;
use Carp;
use Moo;
use namespace::clean;
our $VERSION = "0.01";


has 'app_id' => (
    is => 'rw',
    isa => sub { $_[0] },
    required => 1,
    default => sub { $ENV{ROCKOL_APP_ID} },
);

has 'app_key' => (
    is => 'rw',
    isa => sub { $_[0] },
    required => 1,
    default => sub { $ENV{ROCKOL_APP_KEY} },
);

has 'http' => (
    is => 'rw',
    required => 1,
    default  => sub {
        my $http = Furl::HTTP->new(
            inet_aton => \&Net::DNS::Lite::inet_aton,
            agent => 'WebService::Rockol' . $VERSION,
            headers => [ 'Accept-Encoding' => 'gzip',],
        );
        return $http;
    },
);


my @methods = qw(
    artisti
    biografia
    foto
    video
    testi
    classifiche
    classifica
    concerti
    concerti_settimana
    concerti_oggi
    news_last
    recensioni
    recensione
    storia
);


for my $method (@methods) {
    my $code = sub {
        my ($self, %query_param) = @_;
        return $self->request($method, \%query_param);
    };
    no strict 'refs';
    my $method_name = $method;
    *{$method_name} = $code; 
}


sub request {
    my ( $self, $path, $query_param ) = @_;

    my $query = URI->new;
    $query->query_param( 'app_id', $self->app_id );
    $query->query_param( 'app_key', $self->app_key );
    map { $query->query_param( $_, $query_param->{$_} ) } keys %$query_param;

    my ($minor_version, $status_code, $message, $headers, $content) = 
        $self->http->request(
            scheme => 'http',
            host => 'www.rockol.it',
            path_query => "api/$path.php$query",
            method => 'GET',
        );

    my $data = decode_json( $content );
    if ( $data->{error} ) {
        confess $data->{error};
    } else {
        return $data;
    }
}


1;
__END__

=encoding utf-8

=head1 NAME

WebService::Rockol - A simple and fast interface to the Rockol API

=head1 SYNOPSIS

    use WebService::Rockol;

    my $rockol = new WebService::Rockol(
        'app_id' => 'YOUR_APP_ID',
        'app_key' => 'YOUR_APP_KEY',
    );

    my $data = $rockol->artisti(mbid => '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab');

=head1 DESCRIPTION

The module provides a simple interface to the Rockol API. To use this module, you must first sign up at https://rockol.3scale.net/ to receive an Application ID and key.

=head1 METHODS
These methods usage: https://rockol.3scale.net/docs

=head3 artisti

=head3 biografia

=head3 foto

=head3 video

=head3 testi

=head3 classifiche

=head3 classifica

=head3 concerti

=head3 concerti_settimana

=head3 concerti_oggi

=head3 news_last

=head3 recensioni

=head3 recensione

=head3 storia

=head1 SEE ALSO

https://rockol.3scale.net/docs

=head1 LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hondallica E<lt>hondallica@gmail.comE<gt>

=cut
