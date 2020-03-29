require_relative '../../app/covidence/reviewer'

describe Covidence::Reviewer do
  describe 'add_Review' do
    it 'increases the no. of Reviews when review added' do
      r = Covidence::Reviewer.new
      r.add_review(review: 'fake review')
      expect(r.reviews.length).to eq(1)
    end
  end
end
