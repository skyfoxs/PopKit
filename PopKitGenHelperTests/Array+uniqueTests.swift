//
//  Array+uniqueTests.swift
//  PopKitGenHelperTests
//
//  Created by Pakornpat Sinjiranon on 25/6/23.
//

import XCTest
@testable import PopKitGenHelper

final class Array_uniqueTests: XCTestCase {

    func testArrayUnique_shouldRemoveAllDuplicates() throws {
        XCTAssertEqual(["BG","BG", "Primary"].uniqued(), ["BG", "Primary"])
    }

}
