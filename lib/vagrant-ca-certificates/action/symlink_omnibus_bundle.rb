require 'vagrant'
require_relative '../logger'

module VagrantPlugins
  module CaCertificates
    class Action
      class SymlinkOmnibusBundle
        def initialize(app, env)
          @app = app
        end

        def call(env)
          @machine = env[:machine]
          config = @machine.config.ca_certificates

          # HACK: (jbellone) If the Omnibus installer decides to stop
          # shipping their own certificate bundles we can totally get
          # rid of this step. I prefer this over setting the
          # SSL_CERT_FILE environment variable due to not having a clean
          # way to do it globally except for /etc/environment.
          @machine.communicate.tap do |s|
            s.sudo("ln -fsn /etc/pki/tls/cert.pem #{config.omnibus_path}/embedded/ssl/cert.pem")
          end
        end
      end
    end
  end
end
