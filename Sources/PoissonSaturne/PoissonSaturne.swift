import Foundation
import ArgumentParser
import Cocoa

@main
struct PoissonSaturne: ParsableCommand {
    static let configuration = CommandConfiguration(
      subcommands: [],
      helpNames: [.long, .customShort("?")])

    @Argument
    var inputFile: String

    @Option(name: .shortAndLong)
    var width: Int = 256

    @Option(name: .shortAndLong, help: "(default: equals to width)")
    var height: Int?

    @Option(name: [.customShort("N"), .long])
    var iterations: Int = 10_000

    @Option(name: .shortAndLong, help: "rotation angle (degrees) around x axis")
    var xAxisRotation: Float = 0

    @Option(name: .shortAndLong, help: "rotation angle (degrees) around y axis")
    var yAxisRotation: Float = 0

    @Option(name: .shortAndLong, help: "rotation angle (degrees) around z axis")
    var zAxisRotation: Float = 0

    @Option(name: [.customShort("d"), .long])
    var highDensity: Int = 1

    @Option(name: .shortAndLong)
    var outputFile: String?

    @Flag(name: .long)
    var verbose: Bool = false

    mutating func run() throws {
        let env = try Envelope.read(from: inputFile)
        let size = CGSize(width: width, height: height ?? width)
        let image = imageCreate(env: env, size: size)
        saveAsPNG(fileURL: outputURL, image: image)
    }

    var rotation: Point3D {
        return Point3D(x: Double(xAxisRotation), y: Double(yAxisRotation), z: Double(zAxisRotation))
    }

    func imageCreate(env: Envelope, size: CGSize) -> NSImage {
        let workSize = size * CGFloat(highDensity)
        let bitmap = Bitmap(size: workSize) 
        let cgImg = bitmap.image { _ in
            NSColor.black.setFill()
            CGRect(origin: .zero, size: workSize).fill()
            let renderer = env.renderer(imageSize: workSize, rotation: rotation)
            renderer.render(n: iterations * highDensity * highDensity)
        }
        let image = NSImage(cgImage: cgImg, size: workSize)
        return highDensity != 1 ? image.resized(to: size) : image
    }

    var outputURL: URL {
        if let outputFile = outputFile {
            return URL(fileURLWithPath: outputFile)
        }
        let file = "SolarSail.png"
        return URL(fileURLWithPath: file)
    }

    func saveAsPNG(fileURL: URL, image: NSImage) {
        guard let data = image.pngData else {
            print("no png data")
            return
        }
        do {
            try data.write(to: fileURL, options: .atomic)
            print("succeeded to write \(fileURL.path)")
        } catch {
            print("failed to write \(error)")
        }
    }
}
