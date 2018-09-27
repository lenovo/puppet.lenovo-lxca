# This class provides setting of ip_addresses and job_id for discover_request
#
# @example Declaring the class
#   include lxca_discover_request
#
# @param [String] name - name or title of operation.
# @param [String] ip_addresses - ip_addresses of device. default value: '255.255.255.255'
# @param [String] job_id - job_id to monitor discover request. default value: '0'


class lxca::discover_request(
  String $interface_name = $title,
  String $ip_addresses = '255.255.255.255',
  String $job_id = '0',
  Enum[
    'discover_manageable_devices',
    'monitor_discover_request'] $ensure  = 'discover_manageable_devices',
){
  lxca_discover_request{ $interface_name :
    ensure       => $ensure,
    name         => $interface_name,
    ip_addresses => $ip_addresses,
    job_id       => $job_id,
  }
}
