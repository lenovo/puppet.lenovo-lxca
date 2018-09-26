# This class provides ffdc
#
# @example Declaring the class
#   include lxca_ffdc
#
# @param [String] name - name or title of operation .
# @param [String] uuid - uuid of device.

class lxca::ffdc(
  String $uuid,
  String $interface_name = $title,
  Enum['filter_by_uuid'] $ensure  = 'filter_by_uuid',
){
  lxca_ffdc{ $interface_name :
    ensure => $ensure,
    uuid   => $uuid,
  }
}
