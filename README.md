# README #

This is a demo project that includes custom implementation and analysis of `Array#flatten` algorithm.

### Challenge ###

Write an algorithm to flatten an arbitrarily nested array of integers. e.g. [ 1, [ 2, [ 3 ] ], 4 ] -> [ 1, 2, 3, 4 ]

### Implementation ###

When I started to work on this challenge I realized that there are several ways to achieve the goal:

 - write an elegant code that is clear and straighforward (see `Flatten.reccursive_flatten`);
 - write more progmatic and faster code (see `Flatten.flatten`).

In order to measure results I provided 2 benchmarks: CPU and memory. As expected `Flatten.reccursive_flatten` consumes
much more memory and CPU (especially on big data sets).

### Specs ###

In order to run specs you need to run Bundler and then use `rspec` executable or `rake`:

```
bundle install
rspec --format=doc
```

or:

```
rake spec
```

or:

```
rake
```

### Benchmarks ###

In order to run specs you need to run Bundler and then use `rake`:

```
bundle install
rake benchmark
```

Use parameters in order to customize test data set or number of iterations:

```
rake benchmark[100,10000]
```

Or run only single benchmark (cpu or memory):

```
rake benchmark:cpu[1000,1000]
```

### Code Status ###

[![Build Status](https://travis-ci.org/rzaharenkov/flatten.svg?branch=master)](https://travis-ci.org/rzaharenkov/flatten)
