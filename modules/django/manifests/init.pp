class django {
    include django::install, django::dir, django::clone, django::environment, django::service
}

# specify dependency ordering
Class["django::install"] -> Class["django::clone"] -> Class["django::enviroment"] -> Class["django::service"]


class django::install {
    package { [ "python", "python-dev", "python-virtualenv", "python-pip",
                "python-psycopg2", "python-imaging"]:
        ensure => present,
    }
}

# uses the supervisor module::service type to run gunicorn
# as a monitored service
class django::service {
    include supervisor
    supervisor::service { 'django':
        ensure => present,
        enable => true,
        command => '/usr/local/app/ve/bin/gunicorn_django --workers=9 --bind=127.0.0.1:10001 --pythonpath . settings',
        directory => '/usr/local/app/django',
        user => 'www-data',
    }

    # call the nginx::site to place our conf file
    include nginx
	nginx::site{ 'django':
	    source => 'puppet:///modules/django/django-nginx.conf',
	}
}

class django::dir {
	file { '/usr/local/app':
	    ensure => directory,
	    owner => 'bob',
	    group => 'bob',
	    mode => 755,
	}
}

class django::clone {
    git::clone { 'samuelclay/NewsBlur':
        path => '/usr/local/app',
        dir => 'django',
    }
}

# call the virtualenv we define below
class django::environment {
    django::virtualenv{ 've':
        path => '/usr/local/app',
    }
}

# exec type wrapped in a define for creation of
# a re-usable python virtualenv
define django::virtualenv( $path ){
	exec { "create-ve-$path":
		command => "/usr/bin/virtualenv -q $name",
		cwd => $path,
		creates => "$path/$name",
		require => [Class["django::install"]],
	}
}