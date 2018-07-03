require File.join(File.dirname(__FILE__), '../util/network_device/lxca')
require File.join(File.dirname(__FILE__), '../util/network_device/transport/lxca')
require 'xclarity_client'
require 'json'

class Puppet::Provider::Lxca < Puppet::Provider
  def self.device(url)
    Puppet::Util::NetworkDevice::Lxca::Device.new(url)
  end

  def self.transport
    if Puppet::Util::NetworkDevice.current
      # we are in `puppet device`
      Puppet::Util::NetworkDevice.current.transport
    else
      # we are in `puppet resource`
      Puppet::Util::NetworkDevice::Transport::Lxca.new(Facter.value(:url))
    end
  end

  def self.device_url
    Puppet::Util::NetworkDevice.current ? Puppet::Util::NetworkDevice.current.url.to_s : Facter.value(:url)
  end

  def self.connection
    transport.connection
  end

  # Users Starts here
  def self.get_all_users
    resp = connection.discover_users
    puts "In get_all_users Provider resp = #{resp}"
    resp
  end

  # Jobs Starts here
  def self.get_all_jobs
    resp = connection.discover_jobs
    # puts "In get_all_jobs Provider resp = #{resp}"
    resp
  end

  def self.delete_job(id)
    if id.nil?
      raise Puppet::Error, _('Attribute id is mandatory when ensure is set to delete_job')
    end
    puts 'In delete jobs Provider '
    connection.delete_job(id)
    puts 'In after delete jobs Provider '
  end

  def self.cancel_job(id)
    if id.nil?
      raise Puppet::Error, _('Attribute id is mandatory when ensure is set to cancel_job')
    end
    puts 'In cancel jobs Provider '
    connection.cancel_job(id)
    puts 'In after cancel jobs Provider '
  end

  def self.fetch_manage_request(job_id)
    connection.fetch_manage_request(job_id)
  end

  def self.manage_discovered_devices(ip_address, username, password, recovery_password, force)
    connection.manage_discovered_devices(ip_address, username, password, recovery_password, force)
  end

  def self.fetch_unmanage_request(job_id)
    connection.fetch_unmanage_request(job_id)
  end

  def self.unmanage_discovered_devices(endpoints, force)
    connection.unmanage_discovered_devices(endpoints, force)
  end

  # chassis Starts here
  def self.discover_all_chassis
    connection.discover_chassis
  end

  def self.discover_managed_chassis
    connection.discover_chassis(status: 'managed')
  end

  def self.discover_unmanaged_chassis
    connection.discover_chassis( status: 'unmanaged')
  end

  def self.filter_chassis_by_uuid(uuid)
    connection.fetch_chassis(uuid)
  end

  # cabinet Starts here
  def self.discover_all_cabinets
    connection.discover_cabinet
  end

  def self.filter_cabinets_by_uuid(uuid)
    connection.fetch_cabinet(uuid)
  end

  # canister Starts here
  def self.discover_all_canisters
    connection.discover_canisters
  end

  def self.filter_canisters_by_uuid(uuid)
    connection.fetch_canisters(uuid)
  end

  # cmm Starts here
  def self.discover_all_cmms
    connection.discover_cmms
  end

  def self.filter_cmms_by_chassis(chassis)
    connection.discover_cmms(chassis: chassis)
  end

  def self.filter_cmms_by_uuid(uuid)
    connection.fetch_cmms(uuid)
  end

  # nodes Starts here
  def self.discover_all_nodes
    connection.discover_nodes
  end

  def self.discover_managed_nodes
    connection.discover_nodes(status: 'managed')
  end

  def self.discover_unmanaged_nodes
    connection.discover_nodes(status: 'unmanaged')
  end

  def self.filter_nodes_by_uuid(uuid)
    connection.fetch_nodes(uuid)
  end

  def self.filter_nodes_by_chassis(chassis)
    connection.discover_nodes(chassis: chassis)
  end

  def self.power_on_node(uuid)
    connection.power_on_node(uuid)
  end

  def self.power_off_node(uuid)
    connection.power_off_node(uuid)
  end

  def self.power_restart_node(uuid)
    connection.power_restart_node(uuid)
  end

  def self.blink_loc_led(uuid)
    connection.blink_loc_led(uuid)
  end

  def self.turn_on_loc_led(uuid)
    connection.turn_on_loc_led(uuid)
  end

  def self.turn_off_loc_led(uuid)
    connection.turn_off_loc_led(uuid)
  end

  # discover_request method starts here
  def self.discover_manageable_devices(ip_address)
    connection.discover_manageable_devices(ip_address)
  end

  def self.monitor_discover_request(job_id)
    connection.monitor_discover_request(job_id)
  end

  def self.discover_devices_by_slp
    connection.discover_devices_by_slp
  end

  # discover events start here
  def self.discover_events
    connection.discover_events
  end

  # fan_muxes Starts here
  def self.discover_all_fan_muxes
    connection.discover_fan_muxes
  end

  def self.filter_fan_muxes_by_chassis(chassis)
    connection.discover_fan_muxes(chassis: chassis)
  end

  def self.filter_fan_muxes_by_uuid(uuid)
    connection.fetch_fan_muxes(uuid)
  end

  # fan Starts here
  def self.discover_all_fans
    connection.discover_fans
  end

  def self.filter_fans_by_chassis(chassis)
    connection.discover_fans(chassis: chassis)
  end

  def self.filter_fans_by_uuid(uuid)
    connection.fetch_fans(uuid)
  end

  def self.fetch_ffdc(uuid)
    connection.fetch_ffdc(uuid)
  end

  # power_supplies Starts here
  def self.discover_all_power_supplies
    connection.discover_power_supplies
  end

  def self.filter_power_supplies_by_chassis(chassis)
    connection.discover_power_supplies(chassis: chassis)
  end

  def self.filter_power_supplies_by_uuid(uuid)
    connection.fetch_power_supplies(uuid)
  end

  # scalableComplex Starts here
  def self.discover_all_scalable_complexes
    connection.discover_scalableComplexes
  end

  def self.discover_managed_scalable_complexes
    connection.discover_scalableComplexes(status: 'managed')
  end

  def self.discover_unmanaged_scalable_complexes
    connection.discover_scalableComplexes(status: 'unmanaged')
  end

  def self.discover_flex_scalable_complexes
    connection.discover_scalableComplexes(type: 'flex')
  end

  def self.discover_rackserver_scalable_complexes
    connection.discover_scalableComplexes(status: 'rackserver')
  end

  def self.filter_scalable_complexes_by_uuid(uuid)
    connection.fetch_scalableComplexes(uuid)
  end


  # switches Starts here
  def self.discover_all_switches
    connection.discover_switches
  end

  def self.filter_switches_by_chassis(chassis)
    connection.discover_switches(chassis: chassis)
  end

  def self.filter_switches_by_uuid(uuid)
    connection.fetch_switches(uuid)
  end

  # config target starts here
  def self.fetch_config_target(id)
    connection.fetch_config_target(id)
  end

  # config profile start here
  def self.discover_all_config_profiles
    connection.discover_config_profile
  end

  def self.fetch_config_profile(id)
    connection.fetch_config_profile(id)
  end

  def self.activate_config_profile(id, endpoint_uuid, restart)
    connection.activate_config_profile(id, endpoint_uuid, restart)
  end

  def self.rename_config_profile(id, profile_name)
    connection.rename_config_profile(id, profile_name)
  end

  def self.unassign_config_profile(id, power_down, reset_imm, force)
    connection.unassign_config_profile(id, power_down, reset_imm,force)
  end

  # config pattern starts here
  def self.discover_all_config_paterns
    connection.discover_config_pattern
  end

  def self.fetch_config_pattern(id)
    connection.fetch_config_pattern(id)
  end

  def self.export_config_pattern(id)
    connection.export_config_pattern(id)
  end

  def self.deploy_config_pattern(id, endpoints, restart, etype)
    connection.deploy_config_pattern(id, endpoints, restart, etype)
  end

  def self.import_config_pattern(import_json)
    connection.import_config_pattern(import_json)
  end

  # Generic methods starts here``

  def self.call(url, args = {})
    transport.call(url, args)
  end

  def self.call_items(url, args = { 'expandSubcollections' => 'true' })
    if call = transport.call(url, args)
      call
      # call['item']
    end
  end

  def self.post(url, message)
    transport.post(url, message)
  end

  def self.put(url, message)
    transport.put(url, message)
  end

  def self.delete(url)
    transport.delete(url)
  end

  def self.find_availability(string)
    transport.find_availability(string)
  end

  def self.find_monitors(string)
    transport.find_monitors(string)
  end
end # End of class
