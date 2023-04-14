require 'rails_helper'

RSpec.describe DrugsFacade do
  let(:name) { 'aspirin' }
  let(:service) { instance_double(DrugService) }
  let(:search_results) do
    {
      'drugGroup': {
        'name': nil,
        'conceptGroup': [
          {
            'tty': 'BPCK'
          },
          {
            'tty': 'SBD',
            'conceptProperties': [
              {
                'rxcui': '1009147',
                'name': 'amphetamine aspartate 1.875 MG / amphetamine sulfate 1.875 MG / dextroamphetamine saccharate 1.875 MG / dextroamphetamine sulfate 1.875 MG Oral Tablet [Adderall]',
                'synonym': 'Adderall 7.5 MG Oral Tablet',
                'tty': 'SBD',
                'language': 'ENG',
                'suppress': 'N',
                'umlscui': ''
              },
              {
                'rxcui': '541365',
                'name': 'amphetamine aspartate 7.5 MG / amphetamine sulfate 7.5 MG / dextroamphetamine saccharate 7.5 MG / dextroamphetamine sulfate 7.5 MG Oral Tablet [Adderall]',
                'synonym': 'Adderall 30 MG Oral Tablet',
                'tty': 'SBD',
                'language': 'ENG',
                'suppress': 'N',
                'umlscui': ''
              },
              {
                'rxcui': '541879',
                'name': 'amphetamine aspartate 1.25 MG / amphetamine sulfate 1.25 MG / dextroamphetamine saccharate 1.25 MG / dextroamphetamine sulfate 1.25 MG Oral Tablet [Adderall]',
                'synonym': 'Adderall 5 MG Oral Tablet',
                'tty': 'SBD',
                'language': 'ENG',
                'suppress': 'N',
                'umlscui': ''
              }
            ]
          }
        ]
      }
    }
  end

  before do
    allow(DrugService).to receive(:new).and_return(service)
  end

  describe '#search_results' do
    it 'calls search_results on DrugService and returns the search results' do
      expect(service).to receive(:search_results).with(name).and_return(search_results)

      facade = DrugsFacade.new
      results = facade.search_results(name)

      expect(results).to be_an(Array)
    end
  end
end
