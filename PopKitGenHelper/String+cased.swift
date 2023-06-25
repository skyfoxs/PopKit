//
//  String+cased.swift
//  PopKitGenHelper
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

public extension String {
    var lowercasedFirst: String { prefix(1).lowercased() + dropFirst() }
    var uppercasedFirst: String { prefix(1).uppercased() + dropFirst() }

    /// Return camelCased string without separator
    ///
    /// using separator between each word to make it works correctly.
    /// example, `Background-primary` will return `backgroundPrimary`
    var camelCased: String {
        guard !isEmpty else { return "" }
        let parts = components(separatedBy: .alphanumerics.inverted)
        let first = parts.first!.lowercasedFirst
        let rest = parts.dropFirst().map { $0.uppercasedFirst }

        return ([first] + rest).joined()
    }
}
