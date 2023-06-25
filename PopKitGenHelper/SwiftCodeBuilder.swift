//
//  SwiftCodeBuilder.swift
//  PopKitGenHelper
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

public struct SwiftCodeBuilder {
    public static func makeEnum(_ name: String, with cases: [String]) -> String {
        """
        public enum \(name) {
        \(cases.map(makeEnumCase(for:)).joined(separator: "\n"))
        }
        """
    }

    static func makeEnumCase(for key: String) -> String {
        "    case \(key)"
    }

    public static func makeLetProperty(_ name: String, type: String) -> String {
        "    let \(name): \(type)"
    }
}
