require_relative '../lib/rest.rb'
require_relative '../lib/stats.rb'

@powerball_url = 'https://nationallottery.co.za/index.php?task=results.getHistoricalData&amp;Itemid=272&amp;option=com_weaver&amp;controller=powerball-history'

def draw_history(number_of_draws)
  powerball_response_code, powerball_response = history_request(@powerball_url, 'POWERBALL')

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
    draw_probability[ball] = binomial_probability(hit_rate, number_of_draws, probability)
  end

  draw_summary['powerball_summary'].each do |ball, draws|
    probability = draws.to_f / draw_summary['draw_count'].to_f
    powerball_probability[ball] = binomial_probability(hit_rate, number_of_draws, probability)
  end

  powerball_probability = powerball_probability.sort_by { |ball, draws| -draws }.to_h

  most_probable = draw_probability.keys.first(5).push("powerball: #{powerball_probability.keys.first(1).join}")
  median = draw_probability.size / 2
  median_probable = draw_probability.keys[median - 2..median + 2].push("powerball: #{powerball_probability.keys[powerball_probability.size / 2]}")
  least_probable = draw_probability.keys.last(5).push("powerball: #{powerball_probability.keys.last(1).join}")
  mix_probable = most_probable[2..3] + median_probable[3..4] + least_probable[3..3].push("powerball: #{powerball_probability.keys.first(1).join}")

  puts ''
  puts 'Powerball predictions'
  puts '=========================================='
  puts "Most probable:   #{most_probable}"
  puts "Median probable: #{median_probable}"
  puts "Least probable:  #{least_probable}"
  puts "Mix probable:    #{mix_probable}"
end

draw_history(ARGV[0].to_i)
