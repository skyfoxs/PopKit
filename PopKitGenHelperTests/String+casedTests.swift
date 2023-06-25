//
//  String+casedTests.swift
//  PopKitGenHelperTests
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

import XCTest

final class String_casedTests: XCTestCase {

    func testUppercasedFirst() throws {
        XCTAssertEqual("background-primary".uppercasedFirst, "Background-primary")
    }

    func testLowercasedFirst() throws {
        XCTAssertEqual("Background-primary".lowercasedFirst, "background-primary")
    }

    func testCamelCased() throws {
        XCTAssertEqual("Background-Primary".camelCased, "backgroundPrimary")
        XCTAssertEqual("Background-primary".camelCased, "backgroundPrimary")
        XCTAssertEqual("BackgroundPrimary".camelCased, "backgroundPrimary")
        XCTAssertEqual("Backgroundprimary".camelCased, "backgroundprimary")
    }
}
