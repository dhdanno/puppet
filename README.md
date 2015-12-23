# Sample Puppet Script

This is my first dive into puppet configuration management. Here we have modules / manifests for installing and configurting ssh, git, postgres, django and a supervisor.

There's a custom module for git which breaks away from puppet's declaritive nature to achieve deeper customization.

## Apply the script to a server
<pre>puppet apply --modulepath=/root/puppet/modules/ /root/puppet/manifests/site.pp --debug</pre>

## TODO
 - Set up puppet master for automated / centralized deployments


## More Info
 - http://korel.com.au/configuration-management-with-puppet/
