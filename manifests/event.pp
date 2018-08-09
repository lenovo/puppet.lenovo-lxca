# This class provides lxca event
#
# @example Declaring the class
#   include lxca_event
#
# @param [String] name - name or title of operation .

class lxca::event(
  String $interface_name = $title,
  Enum[
    'present',
    'absent',
    'discover_all'] $ensure  = 'discover_all',
){
  lxca_event{ $interface_name :
    ensure => $ensure,
    name   => $interface_name,
  }
}
