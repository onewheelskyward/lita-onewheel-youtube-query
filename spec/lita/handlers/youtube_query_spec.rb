require 'spec_helper'

describe Lita::Handlers::YoutubeQuery, lita_handler: true do
  it { is_expected.to route_command('youtube') }
  it { is_expected.not_to route('y') }

  it 'youtubes' do
    send_command 'youtube fix it'
    expect(replies.last).to eq('x')
  end
end
