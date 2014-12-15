require 'vagrant'

module VagrantPlugins
  module CaCertificates
    class Plugin < Vagrant.plugin('2')
      guest_capability 'debian', 'update_certificates' do
        require_relative 'cap/debian/update_certificates'
        Cap::Debian::UpdateCertificates
      end

      guest_capability 'debian', 'trust_bundle_path' do
        require_relative 'cap/debian/trust_bundle_path'
        Cap::Debian::TrustBundlePath
      end

      guest_capability 'redhat', 'update_certificates' do
        require_relative 'cap/redhat/update_certificates'
        Cap::Redhat::UpdateCertificates
      end

      guest_capability 'redhat', 'trust_bundle_path' do
        require_relative 'cap/redhat/trust_bundle_path'
        Cap::Redhat::TrustBundlePath
      end
    end
  end
end
