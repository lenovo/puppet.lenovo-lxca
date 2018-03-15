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

