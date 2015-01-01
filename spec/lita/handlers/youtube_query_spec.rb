require 'spec_helper'

describe Lita::Handlers::YoutubeQuery, lita_handler: true do
  it { is_expected.to route('!youtube') }
  it { is_expected.to route('!y') }

  it '!youtubes' do
    send_message '!youtube fix it'
    expect(replies.last).to eq('x')
  end
end
