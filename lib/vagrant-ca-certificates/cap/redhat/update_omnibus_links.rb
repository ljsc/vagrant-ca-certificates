module VagrantPlugins
  module CaCertificates
    module Cap
      module Redhat
        # Capability for configuring the certificate bundle for Omnibus
        # Chef installation for Redhat.
        module UpdateOmnibusLinks
          def self.update_omnibus_links(m)
            omnibus_path = m.config.omnibus_path
            trust_bundle = '/etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt'
            m.communicate.sudo("ln -fsn #{trust_bundle} #{omnibus_path}/embedded/ssl/cert.pem")
          end
        end
      end
    end
  end
end
