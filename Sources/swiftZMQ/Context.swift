import Foundation
import zeromq

extension swiftZMQ {

    public class Context {

        public var handle: UnsafeMutableRawPointer?

        public init() throws {

            let context = zmq_ctx_new()

            guard context != nil else {
                throw zmqError.last
            }

            handle = context
        }
    }
}
