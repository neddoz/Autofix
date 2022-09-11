//
//  ListingCellTests.swift
//  AutoFixTests
//
//  Created by kayeli dennis on 11/09/2022.
//

import XCTest
@testable import AutoFix

class ListingCellViewModelTests: XCTestCase {

    var sut: ListingCellViewModel!
    var mockClient: MockClient!

    override func setUp() {
        super.setUp()
        self.mockClient = MockClient()
        self.sut = .init(ListingCellViewModel(mockClient.getsampleListing()))
    }

    override func tearDown() {
        super.tearDown()
        mockClient = nil
    }

    func test_computes_Correctly() {
        let item = mockClient.getsampleListing()
        XCTAssertEqual(sut.title, NSMutableAttributedString().bold(item.title))
        XCTAssertEqual(sut.price, "Ksh 1,459,000")
        XCTAssertEqual(sut.mileage, "123,456 km")
        XCTAssertEqual(sut.yearOfManufucture, "2014")
    }

}
