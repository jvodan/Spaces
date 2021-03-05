module Providers
  class Lxd < ::Providers::Provider
    class Volume < ::Providers::Volume

      def blueprint_stanzas_for(_)
        %Q(
          resource "lxd_volume" "#{volume_name}" {
            name = "#{volume_name}"
            pool = "#{pool_name}"
          }
        )
      end

      def device_stanzas
        %Q(
          device {
            name = "#{volume_name}"
            type = "disk"
            properties = {
              path = "#{destination}"
              source = "#{volume_name}"
              pool = "#{pool_name}"
            }
          }
        )
      end

      def volume_name; "#{blueprint_identifier}-#{source}" ;end
      def pool_name; "#{source}-pool" ;end

    end
  end
end
