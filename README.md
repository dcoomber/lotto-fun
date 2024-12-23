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
cp -i .env.example .env
docker compose build && docker compose run app
```

### Sample output

```
Lotto predictions for 10 draw(s)
======================================================
Most probable:   [1, 3, 9, 30, 42, 45]
Median probable: [8, 23, 37, 40, 43, 47]
Least probable:  [11, 16, 28, 35, 46, 49]
Mix probable:    [8, 28, 37, 42, 45, 46]

Powerball predictions for 10 draw(s)
======================================================
Most probable:   [19, 34, 35, 38, 46, "powerball: 5"]
Median probable: [9, 18, 42, 43, 50, "powerball: 10"]
Least probable:  [8, 12, 21, 25, 30, "powerball: 15"]
Mix probable:    [18, 19, 25, 34, 50, "powerball: 5"]
```

## Experiments

I try out the predictions and compare the outcome to a randomly selected "quickpick".

Take a look at the [experiments](docs/experiments.md) page for the results.
