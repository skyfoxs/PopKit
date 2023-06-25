//
//  SwiftCodeBuilder+PKColorTests.swift
//  PopKitGenHelperTests
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

import XCTest
@testable import PopKitGenHelper

final class SwiftCodeBuilder_PKColorTests: XCTestCase {

    func testMakePKColor() throws {
        XCTAssertEqual(
            SwiftCodeBuilder.makePKColor(from: ["backgroundPrimary", "backgroundSecondary"]),
            """
            struct PKColor {
                let backgroundPrimary: UIColor
                let backgroundSecondary: UIColor

                func uiColor(for alias: PKColorAlias) -> UIColor {
                    switch alias {
                    case .backgroundPrimary: return backgroundPrimary
                    case .backgroundSecondary: return backgroundSecondary
                    }
                }
            }
            """
        )
    }

    func testMakePKColorExtension() throws {
        XCTAssertEqual(
            SwiftCodeBuilder.makePKColorExtension(
                for: "Pop",
                keys: ["backgroundPrimary", "backgroundSecondary"],
                with: [
                    "backgroundPrimary": ["value": "#ffffffff"],
                    "backgroundSecondary": ["value": "#f5f6f7ff"]
                ]
            ),
            """
            // This code was generated with PopKitGen
            // DO NOT change manually
            import UIKit

            extension PKColor {
                static func makePop() -> PKColor {
                    PKColor(
                        backgroundPrimary: UIColor(hex: "#ffffffff")!,
                        backgroundSecondary: UIColor(hex: "#f5f6f7ff")!
                    )
                }
            }
            """
        )
    }
}
