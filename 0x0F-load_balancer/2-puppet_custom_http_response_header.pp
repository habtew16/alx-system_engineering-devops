# 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Create index.html page
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

# Perform "moved permanently redirection" (301)
file { '/etc/nginx/sites-enabled/default':
  ensure  => file,
  content => template('default_redirect.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Create a 404 Custom error page
file { '/var/www/html/404.html':
  ensure  => file,
  content => 'Ceci n\'est pas une page',
  require => Package['nginx'],
}

# Add custom header X-Served-By
exec { 'add_custom_header':
  command => 'sed -i "/server_name _/a add_header X-Served-By $HOSTNAME;" /etc/nginx/sites-enabled/default',
  path    => ['/bin', '/usr/bin'],
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  require   => File['/etc/nginx/sites-enabled/default'],
}

