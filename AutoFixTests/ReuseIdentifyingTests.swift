//
//  ReuseIdentifyingTests.swift
//  AutoFixTests
//
//  Created by kayeli dennis on 11/09/2022.
//

import XCTest
@testable import AutoFix

class ReuseIdentifyingTests: XCTest {
    
    func test_reuseIdentifier_classIsCalledSomeClass_isSomeClass() {
        class SomeClass: ReuseIdentifying {}
        XCTAssertEqual("SomeClass", SomeClass.reuseIdentifier)
    }
}

