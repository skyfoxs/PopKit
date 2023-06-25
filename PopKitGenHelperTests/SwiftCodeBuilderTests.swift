//
//  SwiftCodeBuilderTests.swift
//  PopKitGenHelperTests
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

import XCTest
@testable import PopKitGenHelper

final class SwiftCodeBuilderTests: XCTestCase {

    func testMakeEnum() throws {
        XCTAssertEqual(
            SwiftCodeBuilder.makeEnum("MyEnum", with: ["first", "second"]),
            """
            public enum MyEnum {
                case first
                case second
            }
            """
        )
    }

    func testMakeLetProperty() throws {
        XCTAssertEqual(
            """
            struct Test {
            \(SwiftCodeBuilder.makeLetProperty("name", type: "String"))
            }
            """,
            """
            struct Test {
                let name: String
            }
            """
        )
    }
}
