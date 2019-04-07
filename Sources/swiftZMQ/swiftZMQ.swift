import zeromq

public struct swiftZMQ {

    public static var version: String {
        var major: Int32 = 0
        var minor: Int32 = 0
        var patch: Int32 = 0
        let _ = zmq_version(&major, &minor, &patch)
        return "\(major).\(minor).\(patch)"
    }

    public enum Capability: String {
        case curve // CURVE security
        case draft // DRAFT APIs
        case ipc // ipc://
        case gssapi // GSSAPI security
        case norm // norm://
        case pgm // pgm://
        case tipc // tipc://
    }

    static public func hasCapability(_ cap: Capability) -> Bool {
        return zmq_has(cap.rawValue) == 1
    }

}
