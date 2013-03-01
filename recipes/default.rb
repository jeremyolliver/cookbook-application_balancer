#
# Cookbook Name:: application_balancer
# Recipe:: default
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

# NOTE: include this ::default recipe to load up the helpers. The application_balancer::server recipe should be included *ONCE* and once only.
unless node.recipes.include?("application_balancer::server")
  Chef::Log.warn("You don't appear to have included the application_balancer::server recipe. Please add it to the end of your run list")
end


if node.run_state[:seen_recipes].include?("rsyslog") || node.run_state[:seen_recipes].include?("rsyslog::default")

  cookbook_file("/etc/rsyslog.d/30-haproxy.conf") do
    source "haproxy.conf"
    owner "root"
    group "root"
    notifies :reload, "service[rsyslog]"
  end

else
  Chef::Log.debug("rsyslog cookbook not detected as loaded, syslog config not written")
end
