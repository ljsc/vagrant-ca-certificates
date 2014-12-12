require 'vagrant'

module VagrantPlugins
  module CaCertificates
    class Plugin < Vagrant.plugin('2')
      # Actions to run before any provisioner or other plugin
      action_hook 'ca_certificates_configure' do |hook|
        require_relative 'action'

        # the standard provision action
        hook.after Vagrant::Action::Builtin::Provision, Action.configure

        # Vagrant 1.5+ can install NFS client
        if check_vagrant_version('>= 1.5.0.dev')
          hook.after Vagrant::Action::Builtin::SyncedFolders, Action.configure
        end

        # Configure the certificates prior to vagrant-omnibus executing.
        # Because of how the Omnibus packages embed certificate bundles
        # we also need to do some special leg work to ensure that Chef
        # will work against our newly minted certificate trusts.
        if defined?(VagrantPlugins::Omnibus::Action::InstallChef)
          hook.before VagrantPlugins::Omnibus::Action::InstallChef, Action.configure(before: true)
          hook.after VagrantPlugins::Omnibus::Action::InstallChef, Action.configure_symlinks
        end
      end
    end
  end
end
