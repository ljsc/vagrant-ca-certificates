module VagrantPlugins
  module CaCertificates
    module Cap
      module Debian
        # Capability for configuring the certificate bundle for Omnibus
        # Chef installation for Debian.
        module UpdateOmnibusLinks
          def self.update_omnibus_links(m)
            omnibus_path = m.config.omnibus_path
            trust_bundle = '/usr/lib/ssl/cert.pem'
            machine.communicate.sudo("ln -fsn #{trust_bundle} #{omnibus_path}/embedded/ssl/cert.pem")
          end
        end
      end
    end
  end
end
