require_relative '../../app/covidence/citation'

describe Covidence::Citation do
  describe '.==' do
    it 'returns true when citation ids are the same' do
      c1 = Covidence::Citation.new(key_value_hash: {citation_id: '123'})
      c2 = Covidence::Citation.new(key_value_hash: {citation_id: '123'})
      expect(c1).to eq(c2)
    end

    it 'returns false when citation ids are not the same' do
      c1 = Covidence::Citation.new(key_value_hash: {citation_id: '123'})
      c2 = Covidence::Citation.new(key_value_hash: {citation_id: '124'})
      expect(c1).not_to eq(c2)
    end

  end

  describe 'add_review' do
    it 'increases the no. of reviews when review added' do
      c = Covidence::Citation.new(key_value_hash: {citation_id: 1})
      c.add_review(review: 'abc')
      expect(c.reviews.length).to eq(1)
    end
  end
end
