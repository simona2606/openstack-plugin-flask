# Flask OpenStack Plugin Example

This repository provides an example of how to extend OpenStack functionality with a simple Flask application. It demonstrates how to create and integrate custom plugins into a DevStack environment.

## Prerequisites

To use this plugin, you'll need to have **DevStack** installed. You can download DevStack from the official repository:

- [Guide on how to install DevStack](https://docs.openstack.org/devstack/latest/)

## Setup Instructions

### 1. Clone the DevStack repository

If you haven't already, clone the DevStack repository to your environment:

```bash
git clone https://github.com/openstack/devstack.git
cd devstack
```

### 2. Add the Plugin to local.conf

Add this repository as an external plugin in your local.conf file by including the following snippet:
```bash
[[local|localrc]]
   ...
enable_plugin flask-openstack-plugin https://github.com/carmine-ambrosino/flask-openstack-plugin.git main
```
