import zeromq

public struct swiftZMQ {

    public static var version: String {
        var major: Int32 = 0
        var minor: Int32 = 0
        var patch: Int32 = 0
        let _ = zmq_version(&major, &minor, &patch)
        return "\(major).\(minor).\(patch)"
    }

}
