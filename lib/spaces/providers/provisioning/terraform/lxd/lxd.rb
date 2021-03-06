module Providers
  class Lxd < ::ProviderAspects::Provider

    def provider_stanzas
      [provider_stanza, pool_stanzas].join
    end

    def provider_stanza
      %(
        provider "#{type}" {
          generate_client_certificates = "#{configuration.generate_client_certificates}"
          accept_remote_certificate    = "#{configuration.accept_remote_certificate}"

          #{remote_stanza}
        }
      )
    end

    def remote_stanza
      %(
        lxd_remote {
          name     = "lxd-server"
          scheme   = "#{arena.configuration.scheme}"
          address  = "#{arena.configuration.address}"
          password = "#{arena.configuration.password}"
          default  = true
          #{optional_port_declaration}
        }
      )
    end

    def optional_port_declaration
      %(port = "#{arena.configuration.port}") if arena.configuration.respond_to?(:port)
    end

    def pool_stanzas
      %(
        resource "#{type}_storage_pool" "data-pool" {
          name = "data"
          driver = "btrfs"
          remote = "lxd-server"
        }

        resource "#{type}_storage_pool" "logs-pool" {
          name = "logs"
          driver = "btrfs"
        }
      )
    end

    def required_stanza
      %(
        lxd = {
          version = "#{configuration.version}"
          source = "#{configuration.source}"
        }
      )
    end

  end
end
