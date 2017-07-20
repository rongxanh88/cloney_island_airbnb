require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'attributes' do
  end

  describe 'relationships' do
    it { should belong_to(:trip) }

    it { should have_many(:messages) }
    it { should have_many(:users) }
  end
end
