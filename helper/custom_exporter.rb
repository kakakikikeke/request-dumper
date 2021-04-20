require 'prometheus/middleware/exporter'

module Prometheus
  module Middleware
    class CustomExporter < Prometheus::Middleware::Exporter

      def respond_with(format)
        guage = @registry.metrics.first
        guage.set(
          online?,
          labels: {
            name: :my_site
          }
        )
        super
      end

      def online?
        0
      end

    end
  end
end
