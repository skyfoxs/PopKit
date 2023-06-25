//
//  PopKit.swift
//  PopKit
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

import UIKit

public class PopKit {
    static var theme: PKTheme?
    static var color: PKColor?

    public static func setUp(theme: PKTheme) {
        PopKit.theme = theme
        PopKit.color = ColorBuilder(theme: theme).build()
    }

    public static func color(for alias: PKColorAlias) -> UIColor {
        guard let color = PopKit.color else {
            fatalError("expect to call PopKit.setUp(theme:) first")
        }
        return color.uiColor(for: alias)
    }
}
