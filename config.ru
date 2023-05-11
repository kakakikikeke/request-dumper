# frozen_string_literal: true

require './app'
require './helper/custom_controller'
require './helper/custom_exporter'
require 'prometheus/middleware/collector'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::CustomExporter
run RequestDumperApp
