module Hydra::Works
  module CurationConcern
    module WithGenericFiles
      extend ActiveSupport::Concern

      included do
        has_and_belongs_to_many :generic_files, predicate: ActiveFedora::RDF::ProjectHydra.hasFile, class_name: "Hydra::Works::GenericFile", inverse_of: :works
        before_destroy :before_destroy_cleanup_generic_files
      end

      def before_destroy_cleanup_generic_files
        generic_files.each(&:destroy)
      end

      def copy_visibility_to_files
        generic_files.each do |gf|
          gf.visibility = visibility
          gf.save!
        end
      end

    end
  end
end
