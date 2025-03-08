module Organizer
	concern :Identifiable do
		class << self
			def by column_name, symbolized: false
				dup.tap do
					it.module_eval do
						included do
							@identified_by = column_name
							@symbolize_ids = symbolized
						end

						class_methods do # public API
							define_method(column_name.to_s.pluralize) { identifiers }
						end
					end
				end
			end
		end

		class_methods do
			def [] id, *ids
				return [ id, *ids ].map { self[it] } if ids.any?

				case id
				when Enumerable
					where   @identified_by => id
				else
					find_by @identified_by => id or
							raise ArgumentError, "Couldn't find #{self} `#{id}`"
				end
			end

			private

			def identifiers
				all.pluck(@identified_by)
						.tap { it.map! &:to_sym if @symbolize_ids }
			end
		end
	end
end
