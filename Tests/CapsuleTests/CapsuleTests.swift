//
//  CapsuleTests.swift
//  Capsule
//
//  Created by Florian Krüger on {TODAY}.
//  Copyright © 2017 Capsule. All rights reserved.
//

import Foundation
import XCTest
import Capsule

class CapsuleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //// XCTAssertEqual(Capsule().text, "Hello, World!")
    }
}

#if os(Linux)
extension CapsuleTests {
    static var allTests : [(String, (CapsuleTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
#endif
