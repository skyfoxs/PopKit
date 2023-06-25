//
//  FlattenKey.swift
//  PopKitGenHelper
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

/// Flatten dictionary until the last one that have value as string.
/// The new key will constuct by `keySeparator` and `keyFormatter`
///
/// Example, with keySeparator as `-`
/// ```swift
/// [
///     "Color": [
///         "BG": [
///             "Primary": [
///                 "value": "#ffffffff"
///             ]
///         ]
///     ]
/// ]
/// ```
/// will got this as a result
/// ```swift
/// [
///     "Color-BG-Primary": [
///         "value": "#ffffffff"
///     ]
/// ]
/// ```
public func flattenKey(
    dictionary: [String: Any],
    keySeparator: String = "-",
    keyFormatter: (String) -> String,
    result: inout [String: Any]
) {
    for key in dictionary.keys {
        if let dict = dictionary[key] as? [String: String] {
            result[keyFormatter(key)] = dict
            continue
        }
        if let dict = dictionary[key] as? [String: Any] {
            var mergedKey = [String: Any]()
            for k in dict.keys {
                mergedKey[key + keySeparator + k] = dict[k]
                flattenKey(
                    dictionary: mergedKey,
                    keySeparator: keySeparator,
                    keyFormatter: keyFormatter,
                    result: &result
                )
            }
        }
    }
}
