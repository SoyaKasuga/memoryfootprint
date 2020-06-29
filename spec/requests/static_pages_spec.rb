require 'rails_helper'

RSpec.describe 'render right page', type: :request do
  context 'GET /' do
    before { get root_path }
    it 'render /' do
      expect(response).to have_http_status 200
    end
    it 'has title & subtitle' do
      expect(response.body).to include 'memoryfootprint'
      expect(response.body).to include 'あの時、あの場所でこんなことがあった。'
      expect(response.body).to include '自分の思い出を足跡に残そう。'
    end
  end
end
