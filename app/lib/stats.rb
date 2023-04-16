def binomial_probability(hit_rate, number_of_draws, probability)
  factorial_n = (1..number_of_draws).reduce(1, :*)
  factorial_k = (1..hit_rate).reduce(1, :*)
  factorial_n_k = (1..number_of_draws-hit_rate).reduce(1, :*)
  binomial_coefficient = factorial_n / (factorial_k * factorial_n_k)
  binomial_coefficient * probability**hit_rate * (1-probability)**(number_of_draws-hit_rate)
end
