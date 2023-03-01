import Foundation

struct Envelope {
    let title: String?
    let factory: Factory
    let formula: Formula
    let start: Point3D
    let center: Point3D
    let size: Point3D
    let velocity: Span
    let acceleration: Span
}

extension Envelope {

    static func read(from filePath: String) throws -> Envelope {
        let fileURL = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileURL)
        let json = try JSONSerialization.jsonObject(with: data)

        if let dict = json as? [String: Any] {
            return try read(from: dict)
        }
        throw EnvelopeError.invalidJSON
    }

    static func read(from dict: [String: Any]) throws -> Envelope {
        guard let name = dict["formula"] as? String else {
            throw EnvelopeError.noKey("formula")
        }
        guard let factory = Factories.singleton.obtain(name: name) else {
            throw EnvelopeError.noFormula(name)
        }
        let formula = try factory.create(from: dict)
        let title = dict["title"] as? String
        guard let d1 = dict["start"] as? [String: Any] else { throw EnvelopeError.noKey("start") }
        guard let d2 = dict["center"] as? [String: Any] else { throw EnvelopeError.noKey("center") }
        guard let d3 = dict["size"] as? [String: Any] else { throw EnvelopeError.noKey("size") }
        guard let d4 = dict["velocity"] as? [String: Any] else { throw EnvelopeError.noKey("velocity") }
        guard let d5 = dict["acceleration"] as? [String: Any] else { throw EnvelopeError.noKey("acceleration") }
        let start = try readPoint3D(from: d1)
        let center = try readPoint3D(from: d2)
        let size = try readPoint3D(from: d3)
        let velocity = try readSpan(from: d4)
        let acceleration = try readSpan(from: d5)
        return Envelope(title: title, factory: factory, formula: formula, start: start, center: center, size: size, velocity: velocity, acceleration: acceleration)
    }

    static func readPoint3D(from dict: [String: Any]) throws -> Point3D {
        guard let x = dict["x"] as? Double else { throw EnvelopeError.noKey("x") }
        guard let y = dict["y"] as? Double else { throw EnvelopeError.noKey("y") }
        guard let z = dict["z"] as? Double else { throw EnvelopeError.noKey("z") }
        return Point3D(x: x, y: y, z: z)
    }

    static func readSpan(from dict: [String: Any]) throws -> Span {
        guard let a = dict["min"] as? Double else { throw EnvelopeError.noKey("min") }
        guard let b = dict["max"] as? Double else { throw EnvelopeError.noKey("max") }
        return Span(min: a, max: b)
    }

    func renderer(imageSize: CGSize, rotation: Point3D) -> Renderer {
        let s: Double = min(imageSize.width, imageSize.height) / max(size.x, size.y, size.z)
        let scale = Affine3D(scaleX: s, y: s, z: s)
        let tr = Affine3D(translationX: -center.x , y: -center.y, z: -center.z)
        let zr = Affine3D(zRotationAngle: rotation.z.radians)
        let yr = Affine3D(yRotationAngle: rotation.y.radians)
        let xr = Affine3D(xRotationAngle: rotation.x.radians)
        let affine3D: Affine3D = xr * yr * zr * scale * tr
        let affine2D = CGAffineTransform(translationX: imageSize.width / 2, y: imageSize.height / 2)
        let proj = Projector(affine3D: affine3D, affine2D: affine2D)
        let color = HSBColorResolver(velocity: velocity, acceleration: acceleration)
        return Renderer(formula: formula, start: start, projector: proj, resolver: color)
    }
}


enum EnvelopeError: Error {
    case invalidJSON
    case noKey(String)
    case noFormula(String)
    case noNumber(String)
    case noParam(String, String)
}
