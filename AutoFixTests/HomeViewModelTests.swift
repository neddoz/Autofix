//
//  HomeViewModelTests.swift
//  AutoFixTests
//
//  Created by kayeli dennis on 11/09/2022.
//

import XCTest
@testable import AutoFix

class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var mockClient: MockClient!

    override func setUp() {
        super.setUp()
        self.mockClient = MockClient()
        self.sut = .init(doIntialFetch: false)
    }

    override func tearDown() {
        super.tearDown()
        mockClient = nil
        self.sut = nil
    }

    func test_computes_Correctly_On_Sucess() {
        mockClient.mockSuccess = true
        mockClient.mockScenario = .listings
        
        sut.fetchItems(with: "\"\"", client: self.mockClient) { _ in
            XCTAssertEqual(self.sut.items.value.count, 1)
            XCTAssertEqual(self.sut.nextItemsLink, nil)
            XCTAssertEqual(self.sut.numberOfRows(), 1)
        }
    }

    func test_computes_Correctly_On_Failure() {
        sut.fetchItems(with: "\"\"", client: self.mockClient) { _ in
            XCTAssert(self.sut.error.value is NetworkError)
            XCTAssertEqual(self.sut.nextItemsLink, nil)
            XCTAssertEqual(self.sut.numberOfRows(), 0)
        }
    }
}
