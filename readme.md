# Happy Plant

### A plant needs:

  - To be watered:
    * < 20s over watering (health penalty)
    * every complete segment of 30s under watering (health penalty)

### TODO?
  - To be sunned:
    * < 30s over sunning (health penalty)
    * every complete segment of 60s under sunning (health penalty)

A plant dies when its health goes below 0.

A plant grows when its health grows above 10.

A plant matures when it reaches 10".

### Game Over:
  - Win reaches 10"
  - Lose it died

## Things We May Need

  - IO/Console gem for manipulating/interacting with the user tty
  - ANSI gem for colors

### Questions

  - If we redraw the screen every X seconds, are going to overload the terminal
    history with garbage?
  - Queue.new in Ruby, threads, and this gist from gary bernhardt: https://gist.github.com/garybernhardt/2963229
