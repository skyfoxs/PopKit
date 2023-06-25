//
//  main.swift
//  PopKitGen
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

import Foundation
import PopKitGenHelper

let directoryPath = "/Users/pakornpat/workspace/experiment/PopKit/PopKit/DesignAssets"

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
        print(
            SwiftCodeBuilder.makePKColorExtension(
                for: fileURL.deletingPathExtension().lastPathComponent,
                keys: keys,
                with: color
            )
        )
    }
    print(
        """
        import UIKit

        \(SwiftCodeBuilder.makePKColor(from: keys))

        \(SwiftCodeBuilder.makeEnum("PKColorAlias", with: keys))
        """
    )
} catch {
    print("Error: \(error.localizedDescription)")
}
