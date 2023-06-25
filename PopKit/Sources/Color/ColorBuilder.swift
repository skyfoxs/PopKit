//
//  ColorBuilder.swift
//  PopKit
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

struct ColorBuilder {
    let theme: PKTheme

    func build() -> PKColor {
        switch theme {
        case .apollo: return PKColor.makeApollo()
        case .vanGogh: return PKColor.makeVanGogh()
        }
    }
}
