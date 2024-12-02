# Factorial Calculation

## Usage

### Erlang

To compile and run the Erlang module:

1. Open the Erlang shell:

   ```bash
   $ erl
   ```

2. Compile the `factorial` module:

   ```erlang
   1> c(factorial).
   {ok,factorial}
   ```

3. Calculate the factorial of 1:

   ```erlang
   2> factorial:calculate(1).
   1
   ```

4. Calculate the factorial of 20:
   ```erlang
   3> factorial:calculate(20).
   2432902008176640000
   ```

### Elixir

To compile and run the Elixir module:

1. Open the Elixir interactive shell:

   ```bash
   $ iex
   ```

2. Compile the `Factorial` module:

   ```elixir
   iex(1)> c("factorial.ex")
   [Factorial]
   ```

3. Calculate the factorial of 1:

   ```elixir
   iex(2)> Factorial.calculate(1)
   1
   ```

4. Calculate the factorial of 20:
   ```elixir
   iex(3)> Factorial.calculate(20)
   2432902008176640000
   ```
