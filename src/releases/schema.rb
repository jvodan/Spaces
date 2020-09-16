require_relative '../spaces/schema'
require_relative '../bindings/bindings'
require_relative '../bindings/anchor'
require_relative '../configuring/configuration'
require_relative '../scaling/scaling'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative '../packages/packages'
require_relative '../packing/images/images'
require_relative '../provisioning/providers/providers'
require_relative '../provisioning/containers/containers'

module Releases
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          title: 0,
          description: 0,
          licenses: [(1..), { label: 1, url: 1 }],
          scaling: 0,
          bindings: 0,
          provider: 0,
          images: 0,
          containers: 0
        }
      end

      def naming_map
        {
          anchor: :binding_anchor
        }
      end

      def division_classes
        [
          Bindings::Bindings,
          Bindings::Anchor,
          Configuring::Configuration,
          Scaling::Scaling,
          OsPackages::OsPackages,
          Nodules::Nodules,
          Packages::Packages,
          Packing::Images::Images,
          Provisioning::Providers::Providers,
          Provisioning::Containers::Containers
        ]
      end
    end

  end
end
