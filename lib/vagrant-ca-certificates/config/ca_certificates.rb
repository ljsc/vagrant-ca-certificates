require 'vagrant'
require 'vagrant/util/downloader'

module VagrantPlugins
  module CaCertificates
    module Config
      class CaCertificates < Vagrant.plugin('2', :config)
        attr_accessor :enabled
        attr_accessor :certs
        attr_accessor :certs_path
        attr_accessor :omnibus_path

        def initialize
          @enabled = UNSET_VALUE
          @certs = UNSET_VALUE
          @certs_path = UNSET_VALUE
          @omnibus_path = UNSET_VALUE
        end

        def finalize!
          @enabled = false if @enabled == UNSET_VALUE
          @certs = [] if @certs == UNSET_VALUE
          @certs_path = '/usr/share/ca-certificates/vagrant' if @certs_path == UNSET_VALUE
          @omnibus_path = '/opt/chef' if @default_omnibus_path == UNSET_VALUE
        end
      end
    end
  end
end
