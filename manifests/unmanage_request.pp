# This class provides setting of variables for unmanage_request
#
# @example Declaring the class
#   include lxca_unmanage_request
#
# @param [String] name - name or title of operation.
# @param [String] endpoints - array of 'ip_address, uuid, type' of device.
#     default value: []
#     example [{'ipAddresses'=>['10.243.8.28'],'type'=>'Chassis','uuid'=>'792812BA57B24337821B72AC27CF2055'}]
# @param [String] job_id - job_id to monitor manage request. default value: '0'
# @param [String] force - force unmanage device. default value: 'False'

class lxca::unmanage_request(
  String $interface_name = $title,
  String $endpoints = '[]',
  String $job_id = '0',
  String $force = 'False',
  Enum[
    'fetch_unmanage_request',
    'unmanage_discovered_devices'] $ensure  = 'unmanage_discovered_devices',
){
  lxca_unmanage_request{ $interface_name :
    ensure    => $ensure,
    name      => $interface_name,
    endpoints => $endpoints,
    force     => $force,
  }
}
