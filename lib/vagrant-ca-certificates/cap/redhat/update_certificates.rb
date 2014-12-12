module VagrantPlugins
  module CaCertificates
    module Cap
      module Redhat
        # Capability for configuring the certificate bundle on Redhat.
        module UpdateCertificates
          def self.update_certificates(machine)
            ca_certs = machine.config.ca_certificates.certs_path

            # TODO: (jbellone) Fix support for older versions of RHEL. We unfortunately
            # still have a need to spin instances that are EL5 and this only seems to
            # work on EL6 and EL7.
            machine.communicate.sudo("mv #{ca_certs}/* /etc/pki/ca-trust/source/anchors/")
            machine.communicate.sudo('update-ca-trust extract')
          end
        end
      end
    end
  end
end
