require 'vagrant'

module VagrantPlugins
  module CaCertificates
    class Plugin < Vagrant.plugin('2')
      guest_capability 'debian', 'update_certificates' do
        require_relative 'cap/debian/update_certificates'
        Cap::Debian::UpdateCertificates
      end

      guest_capability 'redhat', 'update_certificates' do
        require_relative 'cap/redhat/update_certificates'
        Cap::Redhat::UpdateCertificates
      end

      guest_capability 'fedora', 'update_certificates' do
        require_relative 'cap/fedora/update_certificates'
        Cap::Fedora::UpdateCertificates
      end
    end
  end
end
