# NAME

WebService::Rockol - A simple and fast interface to the Rockol API

# SYNOPSIS

    use WebService::Rockol;

    my $rockol = new WebService::Rockol(
        'app_id' => 'YOUR_APP_ID',
        'app_key' => 'YOUR_APP_KEY',
    );

    my $data = $rockol->artisti( country => 'JP' );

# DESCRIPTION

The module provides a simple interface to the Rockol API. To use this module, you must first sign up at https://rockol.3scale.net/ to receive an Application ID and key.

# METHODS
These methods usage: https://rockol.3scale.net/docs

### artisti

### biografia

### foto

### video

### testi

### classifiche

### classifica

### concerti

### concerti\_settimana

### concerti\_oggi

### news\_last

### recensioni

### recensione

### storia

# SEE ALSO

https://rockol.3scale.net/docs

# LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Hondallica <hondallica@gmail.com>
