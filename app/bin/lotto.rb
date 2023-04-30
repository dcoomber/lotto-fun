require_relative '../lib/rest.rb'
require_relative '../lib/stats.rb'

@lotto_url = "https://nationallottery.co.za/index.php?task=results.getHistoricalData&amp;Itemid=265&amp;option=com_weaver&amp;controller=lotto-history"

def draw_history(number_of_draws)
  lotto_response_code, lotto_response = history_request(@lotto_url, 'LOTTO')

  unless (lotto_response_code == 200)
    puts "Invalid history response received."
    exit
  end

  # Draw total
  draw_summary = { 'draw_count' => 0, 'ball_summary' => {} }
  lotto_response['data'].each do |draw|
    draw_summary['draw_count'] += 1
    (1..6).each do |ball|
      draw_summary['ball_summary'][draw["ball#{ball}"]] ||= 0
      draw_summary['ball_summary'][draw["ball#{ball}"]] += 1
    end
  end

  # Probability
  draw_probability = {}
  hit_rate = 1
  draw_summary['ball_summary'].each do |ball, draws|
    probability = draws.to_f / draw_summary['draw_count'].to_f
    draw_probability[ball.to_i] = binomial_probability(hit_rate, number_of_draws, probability)
  end

  draw_probability = draw_probability.sort_by { |ball, draws| -draws }.to_h

  most_probable = draw_probability.keys.first(6)
  median = draw_probability.size / 2
  median_probable = draw_probability.keys[median - 3..median + 2]
  least_probable = draw_probability.keys.last(6)
  mix_probable = most_probable[2..3] + median_probable[2..3] + least_probable[2..3]

  puts ''
  puts 'Lotto predictions'
  puts '=========================================='
  puts "Most probable:   #{most_probable.sort}"
  puts "Median probable: #{median_probable.sort}"
  puts "Least probable:  #{least_probable.sort}"
  puts "Mix probable:    #{mix_probable.sort}"
end

draw_history(ARGV[0].to_i)
