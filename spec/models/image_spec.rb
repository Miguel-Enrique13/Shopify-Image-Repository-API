require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :inventory }
    it { should validate_presence_of :price }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end
end
