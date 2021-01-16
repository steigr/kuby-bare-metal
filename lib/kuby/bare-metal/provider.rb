require 'kuby'
require 'fileutils'
require 'tmpdir'
require 'digest'

module Kuby
  module BareMetal
    class Provider < ::Kuby::Kubernetes::Provider
      attr_reader :config

      def configure(&block)
        config.instance_eval(&block) if block
      end

      def kubeconfig_path
        config.kubeconfig
      end

      def before_setup
        refresh_kubeconfig
      end

      def after_setup
        if nginx_ingress = environment.kubernetes.plugin(:nginx_ingress)
          service = ::KubeDSL::Resource.new(
            kubernetes_cli.get_object(
              'service', nginx_ingress.namespace, nginx_ingress.service_name
            )
          )

          kubernetes_cli.apply(service)
        end
      end

      def before_deploy(*)
        refresh_kubeconfig
      end

      def storage_class_name
        @config.storage_class.freeze
      end

      def kubernetes_cli
        @kubernetes_cli ||= ::KubernetesCLI.new(kubeconfig_path).tap do |cli|
          cli.before_execute do
            refresh_kubeconfig
          end
        end
      end

      private

      def after_initialize
        @config = Config.new
      end

      def refresh_kubeconfig
        Kuby.logger.info("Kubeconfig is at #{kubeconfig_path}")
      end

      def should_refresh_kubeconfig?
        true
      end

      def kubeconfig_dir
        File.dirname(kubeconfig_path)
      end
    end
  end
end
