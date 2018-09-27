# This class provides setting of uuid for chassis
# uuid is required only in some scenario so default
# value is set
#
# @example Declaring the class
#   include lxca_chassis
#
# @param [String] name - name or title of operation.
# @param [String] uuid - uuid of device. default value: 'DUMMY_UUID_FOR_UUID'


class lxca::chassis(
  String $interface_name = $title,
  String $uuid = 'DUMMY_UUID_FOR_UUID',
  Enum[
    'present',
    'absent',
    'discover_managed',
    'discover_unmanaged',
    'filter_by_uuid',
    'discover_all'] $ensure  = 'discover_all',
){
  lxca_chassis{ $interface_name :
    ensure => $ensure,
    name   => $interface_name,
    uuid   => $uuid,
  }
}
