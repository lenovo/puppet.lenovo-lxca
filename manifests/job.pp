# This class provides setting of uuid/id/state for job
#
# @example Declaring the class
#   include lxca_job
#
# @param [String] name - name or title of operation .
# @param [String] uuid - uuid of device. default value: 'DUMMY_UUID_FOR_UUID'
# @param [String] id - id of job . :default value: '0'
# @param [String] state - state of job . :default value: 'Complete'

class lxca::job(
  String $interface_name = $title,
  String $uuid = 'DUMMY_UUID_FOR_UUID',
  String $id = '0',
  Enum[
    'Complete',
    'Cancelled',
    'CancelledWithErrors',
    'CompleteWithErrors',
    'CompleteWithWarnings',
    'Interrupted',
    'Pending',
    'Running',
    'RunningWithErrors',
    'RunningWithWarnings',
    'Skipped',
    'StoppedWithWarnings',
    'Unknown',
    'Uploading',
    'Validating'] $state  = 'Complete',
  Enum[
    'present',
    'absent',
    'cancel_job'] $ensure  = 'cancel_job',
){
  lxca_job{ $interface_name :
    ensure => $ensure,
    name   => $interface_name,
    uuid   => $uuid,
    id     => $id,
    state  => $state,
  }
}
