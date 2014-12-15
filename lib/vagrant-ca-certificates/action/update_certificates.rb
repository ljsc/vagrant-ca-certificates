require 'vagrant'
require_relative '../logger'

module VagrantPlugins
  module CaCertificates
    class Action
      class UpdateCertificates
        def initialize(app, env)
          @app = app
        end

        def call(env)
          @app.call(env)

          m = env[:machine]
          if m.guest.capability?(:update_certificates)
            env[:ui].info I18n.t('vagrant_ca_certificates.certificate.update.pre')
            m.guest.capability(:update_certificates)
            env[:ui].info I18n.t('vagrant_ca_certificates.certificate.update.post')
          else
            env[:ui].error I18n.t('vagrant_ca_certificates.certificate.update.not_supported')
          end
        end
      end
    end
  end
end
