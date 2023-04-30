# Lotto Fun

> Disclaimer:  I don't encourage or endorse gambling as a means to get rich.
> 
> Make sure to read the [LICENSE](./LICENSE) as you accept all responsibility related to the use of this application.

## About

Does history repeat itself?  Probably not in terms of the lottery.

...  but I was bored so I wrote a script to download the lottery history and perform some arbitrary calculations to assess the probability of a number being drawn again.

Maybe I'll buy a few tickets and track the success of the predictions.  Maybe I won't

### The lottery

The South African lottery uses a format called 6/52, which means that six numbers are drawn from a pool of 52 numbers.  The odds of winning the jackpot are therefore 1 in 20,358,520.  These odds remain the same regardless of how many tickets you buy.  The overall odds of winning any prize in the South African Lotto are approximately 1 in 38.

### Powerball

The South African Powerball is a popular lottery game that operates on a similar format to the regular South African Lotto, but with a few key differences.  The game uses two separate drums to draw numbers, with the first drum containing 50 numbers and the second drum containing 20 numbers.

To play, you need to choose five numbers from the first drum, as well as one additional number from the second drum.  The goal is to match all six numbers to win the jackpot prize.

The odds of winning the South African Powerball jackpot are quite low, at 1 in 42,375,200.  However, the game also has several other prize tiers for players who match fewer numbers.  The overall odds of winning any prize in the Powerball game are 1 in 18.

## Using the scripts

```shell
docker-compose build && docker-compose run app
```

### Sample output

```
Lotto predictions
==========================================
Most probable:   ["4", "46", "50", "18", "35", "11"]
Median probable: ["26", "44", "41", "42", "7", "9"]
Least probable:  ["13", "24", "6", "49", "15", "16"]
Mix probable:    ["50", "18", "41", "42", "6", "49"]

Powerball predictions
==========================================
Most probable:   ["20", "33", "44", "37", "16", "powerball: 2"]
Median probable: ["27", "46", "45", "6", "34", "powerball: 8"]
Least probable:  ["32", "17", "39", "25", "13", "powerball: 3"]
Mix probable:    ["44", "37", "6", "34", "25", "powerball: 2"]
```

## Experiments

I try out the predictions and compare the outcome to a randomly selected "quickpick".

Take a look at the [experiments](docs/experiments.md) page for the results.
