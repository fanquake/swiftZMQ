import Foundation
import zeromq

extension swiftZMQ {

    public struct zmqError: Error {
        public let message: String

        public static var last: zmqError {
            guard let errString = zmq_strerror(zmq_errno()) else {
                return zmqError(message: "Failed to retreive zmq_strerror()!")
            }

            return zmqError(message: String(cString: errString))
        }
    }
}
