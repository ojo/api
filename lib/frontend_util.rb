# for config/routes.rb
module ActionDispatch
  module Routing
    class Mapper
      def mount_frontends
        FrontendUtil::FRONTENDS.each do |host|
          reversed = FrontendUtil::to_reversed_sym host
          constraints DomainConstraint.new(["#{host}.dev", host]) do
            mount_ember_app reversed, to: '/'
          end
        end
      end
    end
  end
end

class FrontendUtil
  FRONTENDS = %w(
    www.ojo.world
    www.ttrn.org
  )

  # for EmberCli initializer
  def self.config_ember_app ember_cli_config
    FRONTENDS.each do |d|
      reversed = self.to_reversed_sym d
      ember_cli_config.app reversed, path: Rails.root.join('frontend', reversed)
    end
  end

  def self.to_reversed_sym host
    host.split('.').reverse.join('_')
  end
end
