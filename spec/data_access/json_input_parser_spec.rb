require_relative '../../app/data_access/json_input_parser'

describe JsonInputParser do
  describe 'read_citations_from_input_file' do
    it 'should return an error if file not found' do
      parser = JsonInputParser.new
      expect{parser.read_citations_from_input_file(filename: 'abcdef')}.to raise_error
    end

    it 'should return the correct no. of citations for a valid file' do
      parser = JsonInputParser.new
      citations = parser.read_citations_from_input_file(filename: 'sample_2_citations.json')
      expect(citations.length).to eq(2)
    end
  end
end