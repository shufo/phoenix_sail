# Installation

Add `phoenix_sail` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_sail, "~> 0.1.0"}
  ]
end
```

```bash
$ mix deps.get
```

and run

```bash
$ mix sail.install
```

will install sail configurations.


### Alias

Add alias to your shell environment.

#### bash

```bash
echo alias sail='priv/sail' > ~/.bashrc
```

#### zsh

```bash
echo alias sail='priv/sail' > ~/.zshrc
```

### Run

Sail up and wait for seconds to compilation finished

```elixir
$ sail up -d && sail logs phoenix.test
```