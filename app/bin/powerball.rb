require_relative '../lib/rest.rb'
require_relative '../lib/stats.rb'

number_of_draws = ( ARGV[0].to_i > 0 ) ? ARGV[0].to_i : 1
powerball_url = 'https://www.nationallottery.co.za/index.php?task=results.getHistoricalData&amp;Itemid=272&amp;option=com_weaver&amp;controller=powerball-history'

powerball_response_code, powerball_response = history_request(powerball_url, 'POWERBALL')

unless powerball_response_code == 200
  puts "Invalid history response received."
  exit
end

# Draw total
draw_summary = { 'draw_count' => 0, 'ball_summary' => {}, 'powerball_summary' => {} }
powerball_response['data'].each do |draw|
  draw_summary['draw_count'] += 1
  (1..5).each do |ball|
    draw_summary['ball_summary'][draw["ball#{ball}"]] ||= 0
    draw_summary['ball_summary'][draw["ball#{ball}"]] += 1
  end

  draw_summary['powerball_summary'][draw['powerball']] ||= 0
  draw_summary['powerball_summary'][draw['powerball']] += 1
end

# Probability
draw_probability = {}
powerball_probability = {}
hit_rate = 1
draw_summary['ball_summary'].each do |ball, draws|
  probability = draws.to_f / draw_summary['draw_count'].to_f
  draw_probability[ball.to_i] = binomial_probability(hit_rate, number_of_draws, probability)
end

draw_summary['powerball_summary'].each do |ball, draws|
  probability = draws.to_f / draw_summary['draw_count'].to_f
  powerball_probability[ball.to_i] = binomial_probability(hit_rate, number_of_draws, probability)
end

draw_probability = draw_probability.sort_by { |ball, draws| -draws }.to_h
powerball_probability = powerball_probability.sort_by { |ball, draws| -draws }.to_h

most_probable = draw_probability.keys.first(5)
median = draw_probability.size / 2
median_probable = draw_probability.keys[median - 2..median + 2]
least_probable = draw_probability.keys.last(5)
mix_probable = most_probable[2..3] + median_probable[3..4] + least_probable[3..3]

most_probable_powerball = powerball_probability.keys.first(1).join
median_probable_powerball = powerball_probability.keys[powerball_probability.size / 2]
least_probable_powerball = powerball_probability.keys.last(1).join

puts ''
puts "Powerball predictions for #{number_of_draws} draw(s)"
puts '======================================================'
puts "Most probable:   #{most_probable.sort.push("powerball: #{most_probable_powerball}")}"
puts "Median probable: #{median_probable.sort.push("powerball: #{median_probable_powerball}")}"
puts "Least probable:  #{least_probable.sort.push("powerball: #{least_probable_powerball}")}"
puts "Mix probable:    #{mix_probable.sort.push("powerball: #{most_probable_powerball}")}"
