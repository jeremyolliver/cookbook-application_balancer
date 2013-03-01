#
# Cookbook Name:: application_balancer
# Recipe:: server
#
# Copyright 2012, Jeremy Olliver
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node.run_state[:application_balancer_loaded]
  Chef::Log.error("You have included the application_balancer::server recipe twice, not all attributes will be loaded correctly. Please load once only after attributes are set")
end
node.run_state[:application_balancer_loaded] = true

# Transfer the attributes set in application_balancer (via named keys) over to haproxy
node.default['haproxy']['backend'] = [] unless node['haproxy']['backend']
node.default['haproxy']['frontend'] = [] unless node['haproxy']['frontend']

['frontend', 'backend', 'listen'].each do |block_type|
  node['application_balancer'][block_type].sort.each do |config_name, options|
    node.default['haproxy'][block_type] << options
  end
end

include_recipe("haproxy2")
