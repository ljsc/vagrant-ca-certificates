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
          guest = env[:machine].guest

          # HACK: (jbellone) If the Omnibus installer decides to stop
          # shipping their own certificate bundles we can totally get
          # rid of this step. I prefer this over setting the
          # SSL_CERT_FILE environment variable due to not having a clean
          # way to do it globally except for /etc/environment.
          if guest.capability?(:update_omnibus_links)
            guest.capability(:update_omnibus_links)
          end
        end
      end
    end
  end
end
