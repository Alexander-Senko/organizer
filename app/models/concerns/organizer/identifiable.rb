require 'memery'

module Organizer
	concern :Identifiable do
		class << self
			def by column_name, symbolized: false
				dup.tap do
					_1.module_eval do
						included do
							@identified_by = column_name
							@symbolize_ids = symbolized
						end

						class_methods do # public API
							define_method column_name.to_s.pluralize do
								if @symbolize_ids
									identifiers.map &:to_sym
								else
									identifiers
								end
							end
						end
					end
				end
			end
		end

		class_methods do
			include Memery

			def [] *id
				return id.map { self[_1] } if id.many?

				case id = id.first
				when Enumerable
					where   @identified_by => id
				else
					find_by @identified_by => id or
							raise ArgumentError, "Couldn't find #{self} `#{id}`"
				end
			end

			private

			memoize def identifiers
				all.pluck(@identified_by)
			end
		end
	end
end
