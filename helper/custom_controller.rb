require 'prometheus/client'

module Prometheus
  module Controller
    prometheus = Prometheus::Client.registry
    gauge = Prometheus::Client::Gauge.new(:online_flag, 'Check the flag whether it is online')
    prometheus.register(gauge)
  end
end
