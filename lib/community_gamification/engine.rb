# frozen_string_literal: true

module ::CommunityGamification
  class Engine < ::Rails::Engine
    engine_name PLUGIN_NAME
    isolate_namespace CommunityGamification
  end
end
