# This class provides setting of variables for manage_request
#
# @example Declaring the class
#   include lxca_manage_request
#
# @param [String] name - name or title of operation.
# @param [Array] ip_address - ip_address of device. default value: ['255.255.255.255']
# @param [String] job_id - job_id to monitor manage request. default value: '0'
# @param [String] user - credential of device. default value: 'device_user'
# @param [String] password - credential of device . default value: 'device_password'
# @param [String] recovery_password - recovery password for device. default value: 'device_recovery_password'
# @param [String] force - force manage device. default value: 'False'


class lxca::manage_request(
  String $interface_name = $title,
  Array $ip_address = ['255.255.255.255'],
  String $job_id = '0',
  String $user = 'device_user',
  String $password = 'device_password',
  String $recovery_password = 'device_recovery_password',
  String $force = 'False',
  Enum[
    'fetch_manage_request',
    'manage_discovered_devices'] $ensure  = 'manage_discovered_devices',
){
  lxca_manage_request{ $interface_name :
    ensure            => $ensure,
    name              => $interface_name,
    ip_address        => $ip_address,
    job_id            => $job_id,
    user              => $user,
    password          => $password,
    recovery_password => $recovery_password,
    force             => $force,
  }
}
