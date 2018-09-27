# This class provides setting of variables  for config pattern
# id is required only in some scenario so default
# value is set
#
# @example Declaring the class
#   include lxca_config_pattern
#
# @param [String] name - name or title of operation.
# @param [String] id - id of config pattern. default value: '0'
# @param [String] endpoints - uuid of endpoints for config pattern. default value: 'DUMMY_UUID_FOR_ENDPOINTS'
# @param [Hash] import_json - json format config pattern to be imported. default value: '{}'
# @param [String] restart - restart endpoint of applying pattern. default value: 'defer'
# @param [String] etype - endpoint type. default value: 'node'

class lxca::config_pattern(
  String $interface_name = $title,
  String $id = '0',
  String $endpoints = 'DUMMY_UUID_FOR_ENDPOINTS',
  #JSON $import_json = {'template_type' => 'SystemInfo','template' => {'contact' => 'contact','description' => 'Pattern created by ruby test API ','location' => 'location','name' => 'Learned-System_Info-99','systemName' => {'autogen' => 'Disable','hyphenChecked' => 'FALSE'},'type' => 'SystemInfo','uri' => '/config/template/62','userDefined' => 'TRUE'}},
  Hash $import_json = {'template_type' => 'SystemInfo'},
  Enum[
    'defer',
    'pending',
    'immediate'] $restart  = 'defer',
    Enum[
      'node',
      'rack',
      'tower'] $etype  = 'node',
  Enum[
    'present',
    'absent',
    'export_config_pattern',
    'import_config_pattern',
    'deploy_config_pattern',
    'filter_by_id',
    'discover_all'] $ensure  = 'discover_all',
){
  lxca_config_pattern{ $interface_name :
    ensure      => $ensure,
    name        => $interface_name,
    id          => $id,
    endpoints   => $endpoints,
    restart     => $restart,
    etype       => $etype,
    import_json => $import_json,
  }
}
