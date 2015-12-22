class django {
    include django::install, django::dir, django::clone, django::environment
}

class django::install {
    package { [ "python", "python-dev", "python-virtualenv", "python-pip",
                "python-psycopg2", "python-imaging"]:
        ensure => present,
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