//
//  ListingDetailViewModelTests.swift
//  AutoFixTests
//
//  Created by kayeli dennis on 11/09/2022.
//

import XCTest
@testable import AutoFix

class ListingDetailViewModelTests: XCTestCase {
    var sut: ListingDetailViewModel!
    var mockClient: MockClient!

    
    override func setUp() {
        super.setUp()
        self.mockClient = MockClient()
        self.sut = .init(carId: "5", client: mockClient)
    }
    
    func test_computes_Correctly() {
        XCTAssertEqual(sut.infoItems.value.count, 5)
        XCTAssertEqual(sut.title, mockClient.getSampleListingDetail().carName)
    }
}
