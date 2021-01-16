require 'kuby/bare-metal/provider'

module Kuby
  module BareMetal
    autoload :Config, 'kuby/bare-metal/config'
  end
end

Kuby.register_provider(:bare_metal, Kuby::BareMetal::Provider)
