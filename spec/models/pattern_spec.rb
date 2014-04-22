require 'spec_helper'

describe Pattern do

  describe 'validations' do
    it "validates presence of basically every column"
  end

  describe 'associations' do
    it { should belong_to(:designer) }

  end

end
