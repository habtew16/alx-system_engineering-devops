#!/usr/bin/env bash
# 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Configure custom HTTP header in Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  replace => true,
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  require   => File['/etc/nginx/sites-available/default'],
}
