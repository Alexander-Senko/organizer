module Organizer
	concern :Identifiable do
		class << self
			def by column_name
				dup.tap do
					_1.module_eval do
						included do
							@identified_by = column_name
						end

						class_methods do # public API
							define_method(column_name.to_s.pluralize) { identifiers }
						end
					end
				end
			end
		end

		class_methods do
			def [] *id
				return id.map { self[_1] } if id.many?

				case id = id.first
				when Enumerable
					id.filter_map { identified_as _1 }
				else
					identified_as id or
							raise ArgumentError, "Couldn't find #{self} `#{id}`"
				end
			end

			private

			def identifiers
				@identifiers ||= # cache
						all.pluck(@identified_by)
								.map &:to_sym
			end

			def identified_as identifier
				(@identified ||= {}.with_indifferent_access)[identifier] ||= # cache
						find_by @identified_by => identifier
			end
		end
	end
end
