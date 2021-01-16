require 'kube-dsl'
require 'digest'

module Kuby
  module BareMetal
    class Config
      extend ::KubeDSL::ValueFields

      value_fields :kubeconfig, :storage_class

      def hash_value
        Digest::SHA256.hexdigest(
          [kubeconfig, storage_class].join(':')
        )
      end
    end
  end
end
