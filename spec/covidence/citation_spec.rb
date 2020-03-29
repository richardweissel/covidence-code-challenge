require_relative '../../app/covidence/citation'
require_relative '../../app/covidence/reviewer'
require_relative '../../app/covidence/review'
require_relative '../../app/covidence/review_exists_error'

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
      c.add_review(review: review(c))
      expect(c.reviews.length).to eq(1)
    end

    it 'raises error if review already exists' do
      c = Covidence::Citation.new(key_value_hash: {citation_id: 1})
      c.add_review(review: review(c))
      expect{ c.add_review(review: review(c)) }.to raise_error(Covidence::ReviewExistsError)
    end
  end

  def review(citation)
    Covidence::Review.new(reviewer: create_reviewer, citation: citation, outcome_is_approved: false)
  end

  def create_reviewer
    Covidence::Reviewer.new(1)
  end
end
