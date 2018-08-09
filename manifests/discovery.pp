# This class provides Discovery by slp
#
# @example Declaring the class
#   include lxca_discovery
#
# @param [String] name - name or title of operation .


class lxca::discovery(
  String $interface_name = $title,
  Enum['discover_devices_by_slp'] $ensure  = 'discover_devices_by_slp',
){
  lxca_discovery{ $interface_name :
    ensure  => $ensure,
  }
}
