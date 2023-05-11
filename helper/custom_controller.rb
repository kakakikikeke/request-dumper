# frozen_string_literal: true

require 'prometheus/client'

# A custom controller for prometheus
module Prometheus
  # A module that manages the metrics of whether the app is running
  module Controller
    prometheus = Prometheus::Client.registry
    gauge = Prometheus::Client::Gauge.new(:online_flag,
                                          docstring: 'Check the flag whether it is online',
                                          labels: [:name])
    prometheus.register(gauge)
  end
end
