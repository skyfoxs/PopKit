//
//  main.swift
//  PopKitGen
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

import Foundation
import PopKitGenHelper

#if DEBUG
let directoryPath = "/Users/pakornpat/workspace/experiment/PopKit/PopKit/DesignAssets"
var outputPath: String? = "/Users/pakornpat/workspace/experiment/PopKit/PopKit/Sources/Color/Generated"
//var outputPath: String?
#else
guard 2...3 ~= CommandLine.arguments.count else {
    print("Please provide the path to DesignAssets directory")
    print("PopKitGen path/to/DesignAssets [path/to/Generated]")
    exit(1)
}

let directoryPath = CommandLine.arguments[1]
var outputPath: String?
if CommandLine.arguments.count == 3 {

    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    if fileManager.fileExists(atPath: CommandLine.arguments[2], isDirectory: &isDirectory) {
        if isDirectory.boolValue {
            outputPath = CommandLine.arguments[2]
        } else {
            print("Output path exists but is not a directory. Please specify Generated directory.")
            exit(1)
        }
    } else {
        print("Output directory does not exist.")
        exit(1)
    }
}
#endif

do {
    let fileManager = FileManager.default
    let fileURLs = try fileManager.contentsOfDirectory(
        at: URL(fileURLWithPath: directoryPath),
        includingPropertiesForKeys: nil
    )

    var keys = [String]()
    for fileURL in fileURLs {
        let data = try Data(contentsOf: fileURL)
        let colorConfig = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        var color = [String: Any]()
        flattenKey(
            dictionary: colorConfig["Color"] as! [String: Any],
            keyFormatter: { key in
                key
                    .replacingOccurrences(of: "BG", with: "Background")
                    .split(separator: "-")
                    .uniqued()
                    .joined()
                    .camelCased
            },
            result: &color
        )
        keys = Array(color.keys.sorted())
        let pkColorExtension = SwiftCodeBuilder.makePKColorExtension(
            for: fileURL.deletingPathExtension().lastPathComponent,
            keys: keys,
            with: color
        )
        if let outputPath {
            try pkColorExtension.write(
                to: URL(fileURLWithPath: outputPath)
                    .appending(path: "PKColor+\(fileURL.deletingPathExtension().lastPathComponent).swift"),
                atomically: true,
                encoding: .utf8
            )
        } else {
            print(pkColorExtension)
        }
    }
    let pkColor = """
        // This code was generated with PopKitGen
        // DO NOT change manually
        import UIKit

        \(SwiftCodeBuilder.makePKColor(from: keys))

        \(SwiftCodeBuilder.makeEnum("PKColorAlias", with: keys))

        """
    if let outputPath {
        try pkColor.write(
            to: URL(fileURLWithPath: outputPath)
                .appending(path: "PKColor.swift"),
            atomically: true,
            encoding: .utf8
        )
    } else {
        print(pkColor)
    }
} catch {
    print("Error: \(error.localizedDescription)")
}
