
# This class provides setting of uuid and chassis for node 
# uuid/chassis are required only in some scenario so default
# value is set
#
# @example Declaring the class
#   include lxca_node
#
# @param [String] name - name or title of operation .
# @param [String] uuid - uuid of device .
# @param [String] chassis - chassis or title of operation .

class lxca::node (
  String $interface_name = $title,
  String $uuid = 'DUMMY_UUID_FOR_UUID',
  String $chassis = 'DUMMY_UUID_FOR_CHASSIS',
  Enum[
    'present',
    'absent',
    'discover_managed',
    'discover_unmanaged',
    'filter_by_chassis',
    'filter_by_uuid',
    'power_on',
    'power_off',
    'power_restart',
    'blink_led',
    'turn_on_led',
    'turn_off_led',
    'discover_all'] $ensure  = 'discover_all',
){
  lxca_node{ $interface_name :
    ensure  => $ensure,
    name    => $interface_name,
    uuid    => $uuid,
    chassis => $chassis,
  }
}
