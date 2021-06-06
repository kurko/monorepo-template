# analysis

This is a Typescript codebase that contains a wrapper around the analysis
algorithm. It's for usage in the backend.

## Usage

Use the following command:

```
node dist/index.js some_command --arg-name some-value
```

This will return a JSON response in STDOUT for other systems to read from.

### Analysis

TBD

## Developing

The `analysis` codebase is embedded into `build` when `bin/build` is executed.
That means this codebase is merged with `analysis` and can be taken elsewhere
and run independently.

I suggest running `tsc --watch` in another tab, so as you modify the TypeScript
files, you can run `node build/index.js`. Notice that this is `build/`, not
`dist/`.

## Releases

There are 2 steps, building and releasing. Building will compile TS into regular
Javascript code, one JS file per TS file. Releasing concatenates all of them
into one self-contained file.

To build it into the `build/` dir, run:

```
bin/build
```

To concatenate all files into `dist/index.js` so that can be loaded anywhere,

```
yarn dist
```

## Testing

To run the tests,

```
yarn jest
```
