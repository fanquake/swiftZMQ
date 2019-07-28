# swiftZMQ

Swift 5 bindings for [ØMQ](http://zeromq.org/) 4.x (WIP).

ZeroMQ must be available.
```bash
brew install zeromq
```

Inside your projects `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/fanquake/swiftZMQ", .branch("master"))
],
```

## Example

Subscribe to a `bitcoind` socket streaming `hashtx` & `hashblock` messages.

```bash
# Run bitcoind
src/bitcoind -zmqpubhashtx=tcp://127.0.0.1:28332 -zmqpubrawtx=ipc:///tmp/bitcoind.tx.raw -zmqpubhashtxhwm=10000
```

```swift
import Foundation
import swiftZMQ

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }

    func asString() -> String {
        return String(bytes: self, encoding: .utf8)!
    }
}

print("swiftZMQ: \(swiftZMQ.version)")

let ctx = try swiftZMQ.Context()

let socket = try swiftZMQ.Socket(ctx: ctx, type: .subscribe)

try socket.connect("tcp://0.0.0.0:28333")

try socket.subscribe("hashtx")
try socket.subscribe("hashblock")

repeat {
    let msg = try socket.recvMultipart()
    print(msg[0].asString())
    print(msg[1].hexEncodedString())
} while true
```

```bash
swift run
swiftZMQ: 4.3.1
hashtx
37d6c159c076fd6640df7f45548acdcf85387b26abebeae3751ec4fc655053fd
hashtx
256a6d263cede6d97a21226f9de5af7fc6bcd04a5db698a6261db5379e4cab47
hashtx
9d7d333bd737a6e128ea8a936523c30901b5e9f496d38e60e9a9192099e37bef
hashtx
5ae694bc564f8f96f22a38c12e8a3c690682b8ed884b5077eaa17ca027e1dc57
hashtx
ae4630beb7eeb3540034f15f72fa1ad695af26fa34fd113c0ef0c115d44ec2b4
........
```
