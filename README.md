# swiftZMQ

Swift 5 bindings for [ØMQ](http://zeromq.org/) 4.x (WIP).

ZeroMQ must be available.
```shell
brew install zeromq
```

Inside your projects `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/fanquake/swiftZMQ", .branch("master"))
],
```
