# analysis

This is a Typescript codebase that contains the algorithms for analysis and
external crawling. This code is meant to be compiled into a single Javascript
file (by Vercel's NCC) and reused by different systems (backend, iOS & Android
apps).

## Building

There are 2 steps, building and releasing. Building will compile TS into regular
Javascript code, one JS file per TS file.

To build it into the `build/` dir, run:

```
npm run build
```

These files aren't so useful, as they're meant as an intermediary step. It's
only useful when all this code is unified into a single file, and that's the
**distribution** process.

To create a new _dist_, run,

```
rpm run dist
```

This should generate `dist/main.js` that can be loaded anywhere.
