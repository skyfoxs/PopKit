//
//  FlattenKeyTests.swift
//  PopKitGenHelperTests
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

import XCTest
@testable import PopKitGenHelper

final class FlattenKeyTests: XCTestCase {

    func testFlattenKey_onFlattedDictionary_shouldReturnTheSame() throws {
        var result = [String: Any]()
        flattenKey(
            dictionary: [
                "BG": [
                    "$type": "color",
                    "$value": "{General Color.Amber.amber-00}"
                ]
            ],
            keySeparator: "-",
            keyFormatter: { $0 },
            result: &result
        )

        assertEqual(
            result,
            [
                "BG": [
                    "$type": "color",
                    "$value": "{General Color.Amber.amber-00}"
                ]
            ]
        )
    }

    func testFlattenKey_shouldReturnFlattedDictionary() throws {
        var result = [String: Any]()
        flattenKey(
            dictionary: [
                "Color": [
                    "BG": [
                        "$type": "color",
                        "$value": "{General Color.Amber.amber-00}"
                    ]
                ]
            ],
            keySeparator: "-",
            keyFormatter: { $0 },
            result: &result
        )

        assertEqual(
            result,
            [
                "Color-BG": [
                    "$type": "color",
                    "$value": "{General Color.Amber.amber-00}"
                ]
            ]
        )
    }

    func testFlattenKey_shouldReturnFlattedDictionary_withDotSeparator() throws {
        var result = [String: Any]()
        flattenKey(
            dictionary: [
                "General Color": [
                    "Metalic": [
                        "metalic+30": [
                            "$type": "color",
                            "$value": "#b59b8c"
                        ]
                    ] as [String : Any],
                    "Honest White": [
                      "$type": "color",
                      "$value": "#ffffff"
                    ]
                ]
            ],
            keySeparator: ".",
            keyFormatter: { $0 },
            result: &result
        )

        assertEqual(
            result,
            [
                "General Color.Metalic.metalic+30": [
                    "$type": "color",
                    "$value": "#b59b8c"
                ],
                "General Color.Honest White":  [
                    "$type": "color",
                    "$value": "#ffffff"
                ]
            ]
        )
    }

    func testFlattenKey_shouldReturnFlattedDictionary_usingFormatterForKeyFormatting() throws {
        var result = [String: Any]()
        flattenKey(
            dictionary: [
                "Color": [
                    "BG": [
                        "BG-Primary-Disable": [
                            "$type": "color",
                            "$value": "{General Color.Special Grey.sgrey-03}"
                        ]
                    ]
                ]
            ],
            keySeparator: "-",
            keyFormatter: {
                $0
                    .replacingOccurrences(of: "BG", with: "Background")
                    .split(separator: "-")
                    .uniqued()
                    .joined()
                    .camelCased
            },
            result: &result
        )

        assertEqual(
            result,
            [
                "colorBackgroundPrimaryDisable": [
                    "$type": "color",
                    "$value": "{General Color.Special Grey.sgrey-03}"
                ]
            ]
        )
    }

    private func assertEqual(
        _ actual: [String: Any],
        _ expected: [String: Any],
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard actual.keys.count == expected.keys.count else {
            XCTFail(
                """
                expect to have the same total key. expect \(expected.keys.count) keys, but got \(actual.keys.count)
                expect to have \(expected.keys), but got \(actual.keys)
                """,
                file: file,
                line: line
            )
            return
        }
        switch (actual, expected) {
        case let (actual, expected) as ([String: String], [String: String]):
            for element in actual.compactMap({ $0 }) {
                XCTAssertTrue(
                    expected.keys.contains(element.key),
                    """
                    expect to have same key, but not found \(element.key) in the expected result
                    actual is \(actual.keys), but expect \(expected.keys)
                    """,
                    file: file,
                    line: line
                )
                XCTAssertEqual(
                    element.value,
                    expected[element.key],
                    """
                    expect to have same value for key \(element.key).
                    got \(element.value), but expect \(String(describing: expected[element.key]))
                    """,
                    file: file,
                    line: line
                )
            }
        case let (actual, expected):
            for element in actual.compactMap({ $0 }) {
                guard expected.keys.contains(element.key) else {
                    XCTFail(
                        """
                        expect to have same key, but not found \(element.key) in the expected result
                        actual is \(actual.keys), but expect \(expected.keys)
                        """,
                        file: file,
                        line: line
                    )
                    return
                }
                guard let actual = actual[element.key] as? [String: Any],
                      let expected = expected[element.key] as? [String: Any] else {
                    XCTFail(
                        """
                        expect to got [String: Any] for both actual and expected.
                        got \(actual), but expected \(expected)
                        """,
                        file: file,
                        line: line
                    )
                    return
                }
                assertEqual(actual, expected, file: file, line: line)
            }
        }
    }

}
