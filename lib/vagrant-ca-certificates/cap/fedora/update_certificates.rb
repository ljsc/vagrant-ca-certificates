module VagrantPlugins
  module CaCertificates
    module Cap
      module Redhat
        # Capability for configuring the certificate bundle on Fedora.
        module UpdateCertificates
          def self.update_certificates(machine)
            ca_certs = machine.config.ca_certificates.certs_path
            machine.communicate.sudo("mv #{ca_certs}/* /etc/pki/ca-trust/source/anchors/")
            machine.communicate.sudo('update-ca-trust extract')
          end
        end
      end
    end
  end
end
