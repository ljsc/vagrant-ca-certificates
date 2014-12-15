module VagrantPlugins
  module CaCertificates
    module Cap
      module Redhat
        module TrustBundlePath
          def self.trust_bundle_path(m)
            return '/etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt' unless m.config.ca_certificates.trust_bundle_path
            m.config.ca_certificates.trust_bundle_path
          end
        end
      end
    end
  end
end
