# This class provides setting of variables for update components
#
# @example Declaring the class
#   include lxca_update_comp
#
# @param [String] name - name or title of operation.
# @param [String] activation_mode - job_id to monitor manage request. default value: '0'
# @param [String] force_update_mode - Indicates whether to apply the update if
#                    firmware is already compliant. default value: 'False'
# @param [String] on_error_mode - Indicates how to handle errors during the firmware update. default value: 'stopdeviceOnError'
# @param [String] server - array of hash.
#     default value: []
#     example [{"UUID"=> "B6E2AB7AC3A411E08B8D5CF3FC6E2488","Components"=> [{"Fixid"=> "ibm_fw_imm2_1aoo78j-6.20_anyos_noarch",
#                             "Component"=> "IMM2 (Primary)"}]}]
# @param [String] cmm - array of hash.
#     default value: []
#     example [{"UUID"=> "B6E2AB7AC3A411E08B8D5CF3FC6E2488","Components"=> [{"Fixid"=> "ibm_fw_imm2_1aoo78j-6.20_anyos_noarch",
#                             "Component"=> "IMM2 (Primary)"}]}]
# @param [String] switch - array of hash.
#     default value: []
#     example [{"UUID"=> "B6E2AB7AC3A411E08B8D5CF3FC6E2488","Components"=> [{"Fixid"=> "ibm_fw_imm2_1aoo78j-6.20_anyos_noarch",
#                             "Component"=> "IMM2 (Primary)"}]}]
# @param [String] storage - array of hash.
#     default value: []
#     example [{"UUID"=> "B6E2AB7AC3A411E08B8D5CF3FC6E2488","Components"=> [{"Fixid"=> "ibm_fw_imm2_1aoo78j-6.20_anyos_noarch",
#                             "Component"=> "IMM2 (Primary)"}]}]


class lxca::update_comp(
  String $interface_name = $title,
  String $server = '[]',
  String $cmm = '[]',
  String $switch = '[]',
  String $storage = '[]',

  String $force_update_mode = 'False',
  Enum[
    'stopOnError',
    'stopdeviceOnError',
    'continueOnError'] $on_error_mode  = 'stopdeviceOnError',
  Enum[
    'immediate',
    'delayed'] $activation_mode  = 'immediate',
  Enum[
    'discover_firmware_update_status',
    'apply_firmware_update',
    'cancel_firmware_update',
    'modify_power_state',
    'discover_updatable_device_comp'] $ensure  = 'discover_updatable_device_comp',
){
  lxca_update_comp{ $interface_name :
    ensure            => $ensure,
    name              => $interface_name,
    activation_mode   => $activation_mode,
    force_update_mode => $force_update_mode,
    on_error_mode     => $on_error_mode,
    server            => $server,
    cmm               => $cmm,
    switch            => $switch,
    storage           => $storage,
  }
}
