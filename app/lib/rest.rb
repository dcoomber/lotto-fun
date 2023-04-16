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
  request["Cookie"] = "2b42a5900eca15e8f83f64787af73f39=d9k8omsqb9fgm6lij9tf6u76i3; NSC_ESNS=1e5de8c5-3da6-143a-9678-e638e06afb3d_0597323114_2818328314_00000000026279107854"
  form_data = [['gameName', game_name],['startDate', start_date],['endDate', end_date],['offset', '0'],['limit', '51']]
  request.set_form form_data, 'multipart/form-data'
  response = https.request(request)
  
  [response.code.to_i, JSON.parse(response.read_body)]
end
