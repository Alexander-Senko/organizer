require "test_helper"
require 'minitest/autorun'

describe Organizer::Identifiable do
	let(:described_class) { Organizer::Identifiable }

	describe '.by' do
		subject { described_class.by :id_attribute }

		let(:identifiable) { Class.new.tap { it.include subject } }

		it 'defines a module' do
			_(subject).must_be_instance_of Module

			_(identifiable).must_respond_to :[]
			_(identifiable).must_respond_to :id_attributes
		end
	end

	describe 'included' do
		subject { Model1 }

		let(:n) { 5 }

		before do
			n.times { |code| Model1.find_or_create_by! code: }
		end

		describe '[]' do
			it 'accepts a single ID' do
				_(subject[0].code).must_equal '0'
			end

			it 'accepts multiple IDs' do
				_(subject[0, 1, 2].map &:code).must_equal %w[ 0 1 2 ]
				_ { subject[0, 9999] }.must_raise ArgumentError
			end

			it 'accepts Arrays of IDs' do
				_(subject[[0, 1, 2]].map &:code).must_equal %w[ 0 1 2 ]
				_(subject[[0, 9999]].map &:code).must_equal %w[ 0 ]
			end
		end

		describe '.identifiers' do
			it 'returns all the IDs present' do
				_(subject.codes).must_equal n.times
						.map(&:to_s)
			end

			describe 'symbolized' do
				subject do
					Class.new(Model1).tap do
						it.include Organizer::Identifiable.by :code, symbolized: true
					end
				end

				it 'returns all the IDs present' do
					_(subject.codes).must_equal n.times
							.map(&:to_s)
							.map(&:to_sym)
				end
			end
		end
	end
end
