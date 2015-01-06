require 'vagrant'

module VagrantPlugins
  module CaCertificates
    class Plugin < Vagrant.plugin('2')
      action_hook :ca_certificates_configure do |hook|
        require_relative 'action'

        hook.after Vagrant::Action::Builtin::Provision, Action.configure

        if defined?(VagrantPlugins::Omnibus::Action::InstallChef)
          hook.after VagrantPlugins::Omnibus::Action::InstallChef, Action.configure_symlinks
        end
      end
    end
  end
end
