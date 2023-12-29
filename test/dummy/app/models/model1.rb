class Model1 < ApplicationRecord
	include Organizer::Identifiable.by :code
end
