require 'vagrant'

module VagrantPlugins
  module CaCertificates
    class Plugin < Vagrant.plugin('2')
      action_hook :ca_certificates_configure do |hook|
        require_relative 'action'

        hook.after Vagrant::Action::Builtin::Provision, Action.configure
        hook.after Vagrant::Action::Builtin::Provision, Action.configure_symlinks

        if defined?(VagrantPlugins::Omnibus::Action::InstallChef)
          hook.before VagrantPlugins::Omnibus::Action::InstallChef, Action.configure
          hook.before VagrantPlugins::Omnibus::Action::InstallChef, Action.configure_symlinks
        end
      end
    end
  end
end
