# lxca

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with lxca](#setup)
    * [What lxca affects](#what-lxca-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

lxca module is used to interact with Lenovo XClarity™ Administrator resources through implemented puppet types. 

## Module Description

Lenovo XClarity™ Administrator is a centralized resource management solution that is aimed at reducing complexity, speeding response, and enhancing the availability of Lenovo® server systems and solutions. Using the lxca module, you can interact with the LXCA resources such as nodes, chassis, cmms etc...

In this supported functionality are:
* Listing of all nodes
* Listing of managed nodes
* Listing of unmanaged nodes
* Listing and filtering of nodes using a chassis
* Listing and filtering of nodes using a uuid
* Power on node
* Power off node
* Power restart node
* Blink LOC LED
* Turn on LOC LED
* Turn off LOC LED
* Listing of all chassis
* Listing of managed chassis
* Listing of unmanaged chassis
* Listing and filtering of chassis using a uuid

## Setup
Once the lxca module becomes a part of the Puppet Forge, it can be installed using the command:
puppet module install lxca

Till then, download the entire contents of this repository to the directory /etc/puppetlabs/code/modules/lxca on the Puppet server

### Beginning with Lxca Module in puppet

Before you can use the lxca module, you must create a proxy system able to run puppet device. 
Your Puppet agent will serve as the proxy for the puppet device subcommand.


## Usage


### Installation Requirements 

The following infrastructure is required for the use of Lxca module:

1. A server running as a Puppet Master
2. A Puppet Agent running as a Puppet Device proxy to the lxca 
3. A Lxca device running having static ip and hostname/FQDN 

### Installation and Configuration Steps

1.  Install Puppet Lxca Module on Puppet Master
2.  Install Lxca and xClarity Client gems on Puppet Agent, running as proxy to the Lxca device 
3.  Create a device.conf file on the Puppet Agent node with details of the Lxca device
4.  Run Puppet Device command on the Puppet Agent to initiate registration with the Puppet Master
5.  Creating, Updating and Applying Manifests (Resources) to create a catalog on Puppet Master
6.  Classify the Lxca device to the applied Manifests (Resources) from PE console
7.  Run Configuration Task to the Lxca device per Catalog from Puppet Master

See below for the detailed steps.

#### Step One: Install Puppet Lxca Module on Puppet Master

To install the module run, 

puppet module install lenovo-lxca

#### Step Two: Install Lxca and Rest-Client gems on Puppet Agent

To install the gem files on Puppet Agent
 
/opt/puppetlabs/puppet/bin/gem install xclarity_client

To handle xclarity_client gem dependencies on Puppet Agent, 'Package' resource is used for reference gems on init.pp manifest file on Puppet Master under Lxca Module path. Sample manifest looks like;

```ruby
class cnos::install {
 if $::puppetversion and $::puppetversion =~ /Puppet Enterprise/ {
   $provider = 'pe_gem'
 } elsif $::puppetversion and versioncmp($::puppetversion, '4.0.0') >= 0 {
   $provider = 'puppet_gem'
 } else {
   $provider = 'gem'
 }
package { 'xclarity_client' :
   ensure => '0.6.1',
   provider => 'puppet_gem',
 }
}
```

#### Step Three: Create a device.conf file on the Puppet Agent

Create a device.conf file in the /etc/puppetlabs/puppet/ directory on Puppet Agent with details of the Lxca 
```ruby
[<FQDN of Lxca>]
type lxca
url https://<USERNAME>:<PASSWORD>@<IP ADDRESS OF Lxca >/
```
In the above example, 
<USERNAME> and <PASSWORD> refer to Puppet's login for the device
FQDN refers to Fully Qualified Domain Name of the switch 

NOTE: Make sure the Lxca is reachable by its FQDN from the Master and Agent instance


#### Step Four: Run Puppet Device command on the Puppet Agent

Run the following command on Puppet Agent to have the device proxy node generate a certificate for the device (switch)
```ruby
puppet device -v
```
Verify the device (switch) FQDN with SSL certificate information is listed on the output of following command on Puppet Master
```ruby
puppet cert list --all
```

Sign the device SSL certificate on Puppet Master
```ruby
puppet cert sign <device FQDN>
puppet cert list --all
```


#### Step Five: Updating and Applying Manifests (Resources)

Manifests are available at /etc/puppetlabs/code/environment/production/modules/lxca/manifests/
To list existing managed lxca nodes modify manifest (for eg: For lxca_node )

Sample Manifest
```ruby
class lxca::node {
  lxca_node { 'list_managed':
    ensure      => 'discover_managed',
  }
}
```

#### Step Six: Classify the Lxca device

Open Puppet Enterprise (PE) Console using https://<FQDN of Puppet Master>/ and enter credentials created during Puppet Enterprise Installation
Click on Classification under Configure section and select the Manifests (Resource - lxca::<class>) and Node (switch/device)

#### Step Seven: Run Configuration Tasks to the Lxca device from Puppet Agent

Run the following commands on Puppet Agent
```ruby
puppet agent --test
puppet device -v --user=root
```

## Reference
### What lxca affects

In the current implementation, LXCA can interact with the following LXCA resources:
* Node
* Chassis

### Setup Requirements **OPTIONAL**

The lxca module needs xclarity_client gem to be installed.

## Usage
### Types and Providers
There are types and the respective providers have been implemented - lxca_node, lxca_chassis, lxca_resource ...

lxca_nodes accepts the following ensurable methods:
discover_all, discover_managed, discover_unmanaged, filter_by_chassis, filter_by_uuid, power_on, power_off, power_restart, blink_led, turn_on_led, turn_off_led


lxca_chassis accepts the following ensurable methods:
discover_all, discover_managed, discover_unmanaged, filter_by_uuid


lxca_resource is a placeholder for ffdc events and other operations that does not logically fall under any resource and is more of a property of the whole LXCA. This will be implemented as requirements are encountered.


A sample manifest is provided below that demonstrates the usage of lxca_node and lxca_chassis:

```puppet
lxca_node{'list_all':
  base_url => 'https://10.243.10.75',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'discover_all',
}

lxca_node{'blink_led':
  base_url => 'https://10.243.10.75',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'turn_on_led',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_chassis{'list_managed':
  base_url => 'https://10.243.10.75',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'discover_managed',
}

lxca_chassis{'filter_by_uuid':
  base_url => 'https://10.243.10.75',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'filter_by_uuid',
  uuid => 'F44E92339683385A8D97CD6348A6F45F',
}
```

## License and Authors
Copyright (C) 2018 Lenovo, Inc. Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
