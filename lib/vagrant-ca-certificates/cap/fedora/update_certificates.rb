module VagrantPlugins
  module CaCertificates
    module Cap
      module Redhat
        # Capability for configuring the certificate bundle on Fedora.
        module UpdateCertificates
          def self.update_certificates(machine)
            machine.communicate.sudo('update-ca-trust extract')
          end
        end
      end
    end
  end
end
