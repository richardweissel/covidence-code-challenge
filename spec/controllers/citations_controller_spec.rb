require_relative '../../app/controllers/citations_controller'

describe CitationsController do
  subject do
    app = described_class.allocate
    app.send :initialize
    app
  end

  describe 'GET' do
    before do
      allow(subject).to receive(:get).and_return([]).at_least(:once)
    end
    context 'GET to /citations' do
      let(:response) { get '/citations' }
      it 'returns status 200' do
        expect(response.status).to eq(200)
      end
    end
  end

end