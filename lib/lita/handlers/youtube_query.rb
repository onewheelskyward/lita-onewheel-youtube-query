require 'google/api_client'
require 'trollop'

module Lita
  module Handlers
    class YoutubeQuery < Handler
      config :google_developer_key

      route(/\!(?:youtube|y)/, :youtube_query)

      def youtube_query(response)
        client = ::Google::APIClient.new(:key => config.google_developer_key,
                                       :authorization => nil)
        youtube = client.discovered_api('youtube', 'v3')

        opts = Trollop::options do
          opt :q, 'Search term', :type => String, :default => 'GoogleSearch'
          opt :maxResults, 'Max results', :type => :int, :default => 25
        end

        opts[:part] = 'id,snippet'
        opts[:q] = response.
        search_response = client.execute!(
            :api_method => youtube.search.list,
            :parameters => opts
        )
        parsed = MultiJson.load search_response.response.body
        search_url, search_text = get_search_url_and_text(parsed, index)

        response.reply "#{search_url} #{search_text}"

      end
      def get_search_url_and_text(parsed, index)
        link = ' http://y2u.be/' + parsed['items'][index]['id']['videoId']
        if link
          return link, parsed['items'][index]['snippet']['title']
        end
      end
    end

    Lita.register_handler(YoutubeQuery)
  end
end
