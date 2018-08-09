# This class provides setting of uuid for scalable complex
# uuid is required only in some scenario so default
# value is set
#
# @example Declaring the class
#   include lxca_scalable_complex
#
# @param [String] name - name or title of operation .
# @param [String] uuid - uuid of device. default value: 'DUMMY_UUID_FOR_UUID'

class lxca::scalable_complex(
  String $interface_name = $title,
  String $uuid = 'DUMMY_UUID_FOR_UUID',
  Enum[
    'present',
    'absent',
    'filter_by_uuid',
    'discover_managed',
    'discover_unmanaged',
    'discover_flex',
    'discover_rackserver',
    'discover_all'] $ensure  = 'discover_all',
){
  lxca_scalable_complex{ $interface_name :
    ensure => $ensure,
    name   => $interface_name,
    uuid   => $uuid,
  }
}
