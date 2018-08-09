# This class provides setting of variables  for config profile
# id is required only in some scenario so default
# value is set
#
# @example Declaring the class
#   include lxca_config_profile
#
# @param [String] name - name or title of operation.
# @param [String] profile_name - new name of profile for rename operation.
# @param [String] id - id of config profile. default value: '0'
# @param [String] endpoint_uuid - uuid of endpoint. default value: 'DUMMY_UUID_FOR_ENDPOINTS'
# @param [Boolean] power_down - power_down device. default value: 'False'
# @param [Boolean] reset_imm - reset imm. default value: 'False
# @param [Boolean] Force - Force operation. default value: 'False'

class lxca::config_profile(
  String $interface_name = $title,
  String $profile_name = 'NEW_PROFILE_NAME',
  String $id = '0',
  String $endpoint_uuid = 'DUMMY_UUID_FOR_ENDPOINTS',
  Boolean $power_down = 'False',
  Boolean $reset_imm = 'False',
  Boolean $force = 'False',
  Enum[
    'defer',
    'immediate'] $restart  = 'defer',
  Enum[
    'present',
    'absent',
    'rename_config_profile',
    'activate_config_profile',
    'unassign_config_profile',
    'delete_config_profile',
    'filter_by_id',
    'discover_all'] $ensure  = 'discover_all',
){
  lxca_config_profile{ $interface_name :
    ensure        => $ensure,
    name          => $interface_name,
    profile_name  => $profile_name,
    id            => $id,
    endpoint_uuid => $endpoint_uuid,
    restart       => $restart,
    power_down    => $power_down,
    reset_imm     => $reset_imm,
    force         => $force,
  }
}
