# VinciDropbox

First implementation of dropbox wrapper for [Vinci](https://github.com/leifg/vinci)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add vinci_dropbox to your list of dependencies in `mix.exs`:

        def deps do
          [{:vinci_dropbox, "~> 0.0.1"}]
        end

  2. Ensure vinci_dropbox is started before your application:

        def application do
          [applications: [:vinci_dropbox]]
        end
