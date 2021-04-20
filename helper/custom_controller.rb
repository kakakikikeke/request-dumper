require 'prometheus/client'

module Prometheus
  module Controller
    prometheus = Prometheus::Client.registry
    gauge = Prometheus::Client::Gauge.new(:online_flag, docstring: 'Check the flag whether it is online', labels: [:name])
    prometheus.register(gauge)
  end
end
