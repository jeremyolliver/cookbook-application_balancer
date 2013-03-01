#
# Cookbook Name:: application_balancer
# Definition:: application_frontend
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

# TODO: merge params such as options nicely with a deep merge.

define :application_frontend, :maxconn => "1000", :option => ["forwardfor"] do
  # other options include [:bind, :role_app, :member_options, :mode, :maxconn, :balance, :option, :server, :default_backend] and more
  # See Section 4.1 of http://haproxy.1wt.eu/download/1.3/doc/configuration.txt for keywords in haproxy

  app = {}
  app["name"] = params[:name]
  app["no option"] = params[:no_option] if params[:no_option]

  params.each do |pname, value|
    next if [:name, :no_option].include? pname
    app[pname.to_s] = params[pname]
  end

  node.default['application_balancer']['frontend'][params[:name]] = app
end
