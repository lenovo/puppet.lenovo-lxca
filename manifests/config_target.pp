# This class provides detail for config targets
# id is config pattern or profile id
#
# @example Declaring the class
#   include lxca_config_target
#
# @param [String] name - name or title of operation.
# @param [String] id - id of config pattern or profile.

class lxca::config_target(
  String $interface_name = $title,
  String $id = '0',
  Enum['filter_by_id'] $ensure  = 'filter_by_id',
){
  lxca_config_target{ $interface_name :
    ensure => $ensure,
    id     => $id,
  }
}
