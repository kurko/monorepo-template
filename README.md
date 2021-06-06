Here are the codebases in this repository:

- `app`: this is the main Rails app that users have access to see their data.
  It has views and ways to access it via browser.
  Here's its [README](app/README.md).
- `analysis`: the JS code that analyzes data. It's used by `analysis-node` and can
  be embeded into mobile codebases because it's pure Javascript. Here's its
  [README](analysis/README.md).
- `analysis-node`: this is a node codebase, a wrapper around `analysis`. `app`
  will use it to access analysis.. Here's its [README](analysis-node/README.md)

Most commands are documented in the `Makefile` in the root directory.

## Setup

We use Docker by default for development, but it's not a requirement. To start
with Docker, run the following:

    make build

For testing,

    make test.build
    make test

### Without Docker

From the main directory, run `bin/setup`. It should, roughly:

- update your bash/zrc env to include `ENGINE_BIN`
- create and migrate database
- bundle install `app` and `analysis` and run their specs

## Development

### Without Docker

From the root folder (outside `app/`), run

    bin/foreman_up

this will run all processes described in the `Procfile.dev` file. You can run
individual processes if you want without Foreman by going to each folder and running commands individually (found inside `Procfile.dev`.

You can prevent a service from running. For example, if you want to run all
except `Sidekiq`, inspecting the file you should see the process name name is
`sidekiq`, so use this instead

    bin/foreman_up -m all=1,sidekiq=0

