use strict;
use Test::More 0.98;

use_ok $_ for qw(
    WebService::Rockol
);

my $rockol = new WebService::Rockol;

isa_ok $rockol, 'WebService::Rockol';
isa_ok $rockol->{http}, 'Furl::HTTP';

$rockol->app_id('YOUR_APP_ID');
is $rockol->app_id, 'YOUR_APP_ID';

$rockol->app_key('YOUR_APP_KEY');
is $rockol->app_key, 'YOUR_APP_KEY';

done_testing;

