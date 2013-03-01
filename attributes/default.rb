default['application_balancer']['listen'] = {}
default['application_balancer']['backend'] = {}
default['application_balancer']['frontend'] = {}


# HAproxy requires UDP to be enabled
override['rsyslog']['protocol'] = 'udp'
