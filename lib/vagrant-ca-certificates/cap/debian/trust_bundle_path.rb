module VagrantPlugins
  module CaCertificates
    module Cap
      module Debian
        module TrustBundlePath
          def self.trust_bundle_path(m)
            return '/etc/ssl/certs/ca-certificates.crt' unless m.config.ca_certificates.trust_bundle_path
            m.config.ca_certificates.trust_bundle_path
          end
        end
      end
    end
  end
end
