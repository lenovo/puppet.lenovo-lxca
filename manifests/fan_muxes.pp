# This class provides setting of uuid/chassis for fan_muxes
# uuid/chassis is required only in some scenario so default
# value is set
#
# @example Declaring the class
#   include lxca_fan_muxes
#
# @param [String] name - name or title of operation .
# @param [String] uuid - uuid of device. default value: 'DUMMY_UUID_FOR_UUID'
# @param [String] chassis - uuid of chassis . :default value: 'DUMMY_UUID_FOR_CHASSIS'


class lxca::fan_muxes(
  String $interface_name = $title,
  String $uuid = 'DUMMY_UUID_FOR_UUID',
  String $chassis = 'DUMMY_UUID_FOR_CHASSIS',
  Enum[
    'present',
    'absent',
    'filter_by_uuid',
    'filter_by_chassis',
    'discover_all'] $ensure  = 'discover_all',
){
  lxca_fan_muxes{ $interface_name :
    ensure  => $ensure,
    name    => $interface_name,
    uuid    => $uuid,
    chassis => $chassis,
  }
}
