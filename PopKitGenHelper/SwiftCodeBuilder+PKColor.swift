//
//  SwiftCodeBuilder+PKColor.swift
//  PopKitGenHelper
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

extension SwiftCodeBuilder {
    public static func makePKColor(from keys: [String]) -> String {
        """
        struct PKColor {
        \(keys.map { SwiftCodeBuilder.makeLetProperty($0, type: "UIColor") }.joined(separator: "\n"))

            func uiColor(for alias: PKColorAlias) -> UIColor {
                switch alias {
        \(keys.map(makeAliasCase(for:)).joined(separator: "\n"))
                }
            }
        }
        """
    }

    fileprivate static func makeAliasCase(for key: String) -> String {
        "        case .\(key): return \(key)"
    }

    public static func makePKColorExtension(
        for theme: String,
        keys: [String],
        with dictionary: [String: Any]
    ) -> String {
        """
        import UIKit

        extension PKColor {
            static func make\(theme.uppercasedFirst)() -> PKColor {
                PKColor(
        \(keys
                .map { key in
                    let dict = dictionary[key] as! [String: String]
                    let color = dict["value"]!
                    return (key, color)
                }
                .map(makeParameter(for:value:))
                .joined(separator: ",\n")
        )
                )
            }
        }
        """
    }

    fileprivate static func makeParameter(for key: String, value: String) -> String {
        "            \(key): UIColor(hex: \"\(value)\")!"
    }
}
