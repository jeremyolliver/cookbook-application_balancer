#
# Cookbook Name:: application_balancer
# Definition:: balanced_app
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

# This allows a shorthand so we don't have to manipulate the attributes ourselves

define :balanced_app, :mode => "http", :maxconn => "100", :balance => "roundrobin", :option => ["redispatch", "nolinger"] do

  app = {}
  app["name"] = params[:name]
  app["no option"] = params[:no_option] if params[:no_option]

  params.each do |pname, value|
    next if [:name, :no_option].include? pname
    app[pname.to_s] = params[pname]
  end
  if app["role_app"]
    app["member_options"] ||= {}
    app["member_options"]["extra"] ||= "weight 1 maxconn 100 check"
  end

  node.default['application_balancer']['listen'][params[:name]] = app
end
