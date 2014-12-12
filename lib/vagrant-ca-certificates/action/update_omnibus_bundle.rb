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
          ui = env[:ui]
          guest = env[:machine].guest
          omnibus_path = env[:machine].config.omnibus_path

          # HACK: (jbellone) If the Omnibus installer decides to stop
          # shipping their own certificate bundles we can totally get
          # rid of this step. I prefer this over setting the
          # SSL_CERT_FILE environment variable due to not having a clean
          # way to do it globally except for /etc/environment.
          if guest.capability?(:update_omnibus_links)
            env[:ui].info I18n.t('vagrant_ca_certificates.omnibus.update_links', path: omnibus_path)
            guest.capability(:update_omnibus_links)
          end
        end
      end
    end
  end
end
