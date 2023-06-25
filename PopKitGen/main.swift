//
//  main.swift
//  PopKitGen
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

import PopKitGenHelper

let apolloJSON = """
{
    "Color": {
        "BG": {
            "Primary": {
                "value": "#ffffffff"
            },
            "Secondary" : {
                "value": "#f5f6f7ff"
            }
        }
    }
}
""".data(using: .utf8)!

let apollo = try! JSONSerialization.jsonObject(with: apolloJSON) as! [String: Any]

var color = [String: Any]()
flattenKey(
    dictionary: apollo["Color"] as! [String: Any],
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

let keys = Array(color.keys.sorted())

func makePKColorAlias(from keys: [String]) -> String {
    func makeEnumCase(for key: String) -> String {
        "    case \(key)"
    }

    let code = ["public enum PKColorAlias {"] + keys.map(makeEnumCase(for:)) + ["}"]
    return code.joined(separator: "\n")
}

print(makePKColorAlias(from: keys))

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

print(makePKColor(from: keys))

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

print(makePKColorExtension(for: "apollo", keys: keys, with: color))
