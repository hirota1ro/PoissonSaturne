import Foundation

struct Span {
    var min: Double
    var max: Double
}

extension Span {
    init() {
        min = .greatestFiniteMagnitude
        max = -.greatestFiniteMagnitude
    }

    mutating func update(_ value: Double) {
        min = Swift.min(min, value)
        max = Swift.max(max, value)
    }

    var isValid: Bool { return min < max }
    var value: Double { return max - min }
    var center: Double { return (max + min) / 2 }
    func normalized(_ value: Double) -> Double { return (value - min) / (max - min) }
}
