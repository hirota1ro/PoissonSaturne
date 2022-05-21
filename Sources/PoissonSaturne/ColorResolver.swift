import Cocoa

protocol ColorResolver {
    func resolve(velocity: Point3D, acceleration: Point3D) -> NSColor
}

// MARK: -

struct StaticColorResolver {
    let color: NSColor
}

extension StaticColorResolver: ColorResolver {
    func resolve(velocity: Point3D, acceleration: Point3D) -> NSColor { return color }
}

// MARK: -

struct HSBColorResolver {
    let velocity: Span
    let acceleration: Span
}

extension HSBColorResolver: ColorResolver {
    func resolve(velocity v: Point3D, acceleration a: Point3D) -> NSColor {
        let hue = velocity.normalized(v.norm)
        let sat = acceleration.normalized(a.norm)
        return NSColor(hue: hue, saturation: sat, brightness: 1, alpha: 1)
    }
}
