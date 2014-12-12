require 'vagrant'

module VagrantPlugins
  module CaCertificates
    class Plugin < Vagrant.plugin('2')
      guest_capability 'debian', 'update_certificates' do
        require_relative 'cap/debian/update_certificates'
        require_relative 'cap/debian/update_omnibus_links'
        Cap::Debian::UpdateCertificates
        Cap::Debian::UpdateOmnibusLinks
      end

      guest_capability 'redhat', 'update_certificates' do
        require_relative 'cap/redhat/update_certificates'
        require_relative 'cap/redhat/update_omnibus_links'
        Cap::Redhat::UpdateCertificates
        Cap::Redhat::UpdateOmnibusLinks
      end
    end
  end
end
