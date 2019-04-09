import Foundation
import zeromq

extension swiftZMQ {

    public enum SocketType: Int32 {

        case pair

        case publish
        case subscribe

        case request
        case reply

        case dealer
        case router

        case push
        case pull

        case xpublish
        case xsubscribe

        case stream

        public var rawValue: Int32 {
            switch self {
            case .pair: return ZMQ_PAIR

            case .publish: return ZMQ_PUB
            case .xpublish: return ZMQ_XPUB

            case .request: return ZMQ_REQ
            case .reply: return ZMQ_REP

            case .dealer: return ZMQ_DEALER
            case .router: return ZMQ_ROUTER

            case .push: return ZMQ_PUSH
            case .pull: return ZMQ_PULL

            case .subscribe: return ZMQ_SUB
            case .xsubscribe: return ZMQ_XSUB

            case .stream: return ZMQ_STREAM
            }
        }
    }
}
