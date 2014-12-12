require 'vagrant/action/builtin/call'
require_relative 'action/is_enabled'
require_relative 'action/only_once'
require_relative 'action/update_omnibus_bundle'
require_relative 'action/update_certificates'
require_relative 'action/upload_certificates'

module VagrantPlugins
  module CaCertificates
    class Action
      # Returns an action middleware stack that configures the VM
      #
      # @param opts [Hash] the options to be passed to {OnlyOnce}
      # @option (see OnlyOnce#initialize)
      def self.configure(opts = {})
        builder = Proc.new do |b|
          b.use Vagrant::Action::Builtin::Call, IsEnabled do |env, b2|
            next unless env[:result]
            b2.use UploadCertificates
            b2.use UpdateCertificates
          end
        end

        Vagrant::Action::Builder.build(OnlyOnce, opts, &builder)
      end

      # Returns an action middleware which symlinks certificate bundles
      # within any Omnibus installers.
      #
      # @param opts [Hash] The options to be passed to {OnlyOnce}.
      # @option (see OnlyOnce::#initalize)
      def self.configure_symlinks(opts = {})
        builder = Proc.new do |b|
          b.use Vagrant::Action::Builtin::Call, IsEnabled do |env, b2|
            next unless env[:result]
            b2.use UpdateOmnibusBundle
          end
        end

        Vagrant::Action::Builder.build(OnlyOnce, opts, &builder)
      end
    end
  end
end
