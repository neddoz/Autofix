//
//  AppRouterTests.swift
//  AutoFixTests
//
//  Created by kayeli dennis on 11/09/2022.
//

import XCTest
@testable import AutoFix

class ApprouterTests: XCTestCase {
    let sut = AppRouter.shared
    var item: ListingDetail?
    
    override func setUp() {
        super.setUp()
        item = MockClient().getSampleListingDetail()
    }

    override func tearDown() {
        item = nil
        super.tearDown()
    }

    func test_root_view_controller_is_HomeViewcontroller() {
        guard let nav = (sut.rootController() as? UITabBarController)?.viewControllers?.first as? UINavigationController else {
            return XCTFail("Failed to grab the navigation controller on the router object")
        }
        XCTAssert(nav.viewControllers.first is HomeViewController)
    }
    
    func test_routes_to_image_detail_view_controller() {
        guard let item = item else {
            return XCTFail("Failed to get the datum")
        }
        
        guard let nav = (sut.rootController() as? UITabBarController)?.viewControllers?.first as? UINavigationController else {
            return XCTFail("Failed to grab the navigation controller on the routeer object")
        }
        
        sut.presentImageDetailViewController(for: item.id)
        XCTAssert(nav.viewControllers.last is ListingDetailViewController)
    }
}
