//
//  main.swift
//  PopKitGen
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

import Foundation
import PopKitGenHelper

func makePKColorAlias(from keys: [String]) -> String {
    func makeEnumCase(for key: String) -> String {
        "    case \(key)"
    }

    let code = ["public enum PKColorAlias {"] + keys.map(makeEnumCase(for:)) + ["}"]
    return code.joined(separator: "\n")
}

func makePKColor(from keys: [String]) -> String {
    func makeProperty(for key: String) -> String {
        "    let \(key): UIColor"
    }

    func makeAliasCase(for key: String) -> String {
        "        case .\(key): return \(key)"
    }

    var code = ["struct PKColor {"]
    code += keys.map(makeProperty(for:))
    code += ["    func uiColor(for alias: PKColorAlias) -> UIColor {"]
    code += ["        switch alias {"]
    code += keys.map(makeAliasCase(for:))
    code += ["        }"]
    code += ["    }"]
    code += ["}"]
    return code.joined(separator: "\n")
}

func makePKColorExtension(for theme: String, keys: [String], with dictionary: [String: Any]) -> String {
    func makeParameter(for key: String, value: String) -> String {
        "            \(key): UIColor(hex: \"\(value)\")"
    }

    var code = ["extension PKColor {"]
    code += ["    static func make\(theme.uppercasingFirst)() -> PKColor {"]
    code += ["        PKColor("]
    code += [
        keys
            .map { key in
                let dict = dictionary[key] as! [String: String]
                let color = dict["value"]!
                return (key, color)
            }
            .map(makeParameter(for:value:))
            .joined(separator: ",\n")
    ]
    code += ["        )"]
    code += ["    }"]
    code += ["}"]
    return code.joined(separator: "\n")
}

let directoryPath = "/Users/pakornpat/workspace/experiment/PopKit/PopKit/DesignAssets"

do {
    let fileManager = FileManager.default
    let fileURLs = try fileManager.contentsOfDirectory(
        at: URL(fileURLWithPath: directoryPath),
        includingPropertiesForKeys: nil
    )

    var keys = [String]()
    for fileURL in fileURLs {
        print("Start generate for:", fileURL.deletingPathExtension().lastPathComponent)

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
            makePKColorExtension(
                for: fileURL.deletingPathExtension().lastPathComponent,
                keys: keys,
                with: color
            )
        )
    }
    print(makePKColorAlias(from: keys))
    print(makePKColor(from: keys))

} catch {
    print("Error: \(error.localizedDescription)")
}
