# frozen_string_literal: true

require 'prometheus/middleware/exporter'

module Prometheus
  module Middleware
    # A custom exporter for prometheus
    class CustomExporter < Prometheus::Middleware::Exporter
      def respond_with(format)
        gauge = @registry.get(:online_flag)
        gauge.set(
          online?,
          labels: {
            name: :my_site
          }
        )
        super
      end

      def online?
        1
      end
    end
  end
end
