# Private class
class lxca::install {
  if $::puppetversion and $::puppetversion =~ /Puppet Enterprise/ {
    $provider = 'pe_gem'
  } elsif $::puppetversion and versioncmp($::puppetversion, '4.0.0') >= 0 {
    $provider = 'puppet_gem'
  } else {
    $provider = 'gem'
  }
  package { 'xclarity_client' :
    ensure   => '0.5.4',
    provider => 'gem',
  }
}
