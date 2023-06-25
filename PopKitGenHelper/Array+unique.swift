//
//  Array+unique.swift
//  PopKitGenHelper
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

public extension Array where Element: Hashable {
    func uniqued() -> Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
