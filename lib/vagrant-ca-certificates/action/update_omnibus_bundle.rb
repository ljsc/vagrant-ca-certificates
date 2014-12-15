require 'vagrant'
require_relative '../logger'

module VagrantPlugins
  module CaCertificates
    class Action
      class UpdateOmnibusBundle
        def initialize(app, env)
          @app = app
        end

        def call(env)
          @app.call(env)

          m = env[:machine]
          # HACK: (jbellone) If the Omnibus installer decides to stop
          # shipping their own certificate bundles we can totally get
          # rid of this step. I prefer this over setting the
          # SSL_CERT_FILE environment variable due to not having a clean
          # way to do it globally except for /etc/environment.
          return unless m.guest.capability?(:trust_bundle_path)

          trust_bundle_path = m.guest.capability(:trust_bundle_path)
          embedded_path = File.join(m.config.ca_certificates.omnibus_path, 'embedded/ssl/cert.pem')

          env[:ui].info I18n.t('vagrant_ca_certificates.certificate.update.pre', path: trust_bundle_path)
          m.communicate.sudo("ln -fsn #{trust_bundle_path} #{embedded_path}")
        end
      end
    end
  end
end
