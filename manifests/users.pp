# This class provides lxca users
#
# @example Declaring the class
#   include lxca_users
#
# @param [String] name - name or title of operation .
# @param [String] id - id of user . default value: '0'
class lxca::users(
  String $interface_name = $title,
  String $id = '0',
  Enum[
    'present',
    'absent'] $ensure  = 'present',
){
  lxca_event{ $interface_name :
    ensure => $ensure,
    name   => $interface_name,
    id     => $id
  }
}
