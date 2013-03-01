maintainer       "Jeremy Olliver"
maintainer_email "jeremy.olliver@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures application_balancer"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.2"

depends "haproxy2"
recommends "rsyslog"

# Only tested on ubuntu 10.04 and 12.0.4.1
supports "ubuntu"
supports "debian"

conflicts "haproxy" # Cannot use this together with the haproxy cookbook

provides "application_balancer::default"
provides "application_balancer::server"

provides "balanced_app()"
provides "application_backend()"
provides "application_frontend()"
