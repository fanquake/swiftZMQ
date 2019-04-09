import Foundation
import zeromq

extension swiftZMQ {

    // http://api.zeromq.org/4-0:zmq-socket
    public class Socket {

        public var handle: UnsafeMutableRawPointer?

        public init(ctx: Context, type: SocketType) throws {

            let socket = zmq_socket(ctx.handle, type.rawValue)

            guard socket != nil else {
                throw zmqError.last
            }

            handle = socket
        }

        public func connect(_ endpoint: String) throws {

            guard zmq_connect(handle, endpoint) != -1 else {
                throw zmqError.last
            }
        }

        public func recvMultipart() throws -> [Data] {

            var parts: [Data] = []
            var msg = zmq_msg_t()

            repeat {

                guard zmq_msg_init(&msg) != -1 else {
                    throw zmqError.last
                }

                defer {
                    zmq_msg_close(&msg)
                }

                guard zmq_recvmsg(handle, &msg, 0) != -1 else {
                    throw zmqError.last
                }

                let data = Data(bytes: zmq_msg_data(&msg), count: zmq_msg_size(&msg))

                parts.append(data)

            } while(zmq_msg_more(&msg) > 0)

            return parts
        }

        public func subscribe(_ value: String) throws {

            try value.withCString { v in
                guard zmq_setsockopt(self.handle, ZMQ_SUBSCRIBE, v, value.utf8.count) != -1 else {
                    throw zmqError.last
                }
            }
        }
    }
}
