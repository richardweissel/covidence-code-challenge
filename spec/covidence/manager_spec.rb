require_relative '../../app/covidence/manager'
require_relative '../../app/covidence/citation_not_found_error'

describe Covidence::Manager do
  describe 'create_review' do
    it 'returns no errors when params are valid' do
      data_accessor = instance_double('DataAccessor')
      allow(data_accessor).to receive(:find_or_create_reviewer).and_return('reviewer')
      allow(data_accessor).to receive(:find_citation).and_return('citation')
      allow(data_accessor).to receive(:save_review)
      manager = Covidence::Manager.new(data_accessor)
      manager.create_review(params_hash: {})
    end

    it 'raises an error when the citation is not found' do
      data_accessor = instance_double('DataAccessor')
      allow(data_accessor).to receive(:find_or_create_reviewer).and_return('reviewer')
      allow(data_accessor).to receive(:find_citation).and_return(nil)
      manager = Covidence::Manager.new(data_accessor)
      expect {manager.create_review(params_hash: {citation_id: 123})}.to raise_error.with_message('Citation id 123 not found')
    end
  end
end

