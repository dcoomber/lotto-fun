require 'net/http'
require 'json'
require "uri"
require 'date'

def history_request(url, game_name)
  uri = URI(url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true

  start_date = Date.today.prev_year.strftime('%d/%m/%Y')
  end_date = Date.today.strftime('%d/%m/%Y')

  request = Net::HTTP::Post.new(uri)
  form_data = [['gameName', game_name],['startDate', start_date],['endDate', end_date],['offset', '0'],['limit', '51']]
  request.set_form form_data, 'multipart/form-data'
  response = https.request(request)
  
  [response.code.to_i, JSON.parse(response.read_body)]
end
