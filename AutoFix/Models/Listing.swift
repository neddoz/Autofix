//
//  Listing.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import Foundation

// MARK: - Listing
struct Listing: Codable {
    let id, title: String
    let imageURL: String
    let year: Int
    let city, state: String
    let gradeScore: Double
    let sellingCondition: String
    let hasWarranty: Bool
    let marketplacePrice, marketplaceOldPrice: Int
    let hasFinancing: Bool
    let mileage: Int
    let mileageUnit: String
    let installment: Int
    let depositReceived: Bool
    let loanValue: Int
    let websiteURL: String
    let stats: Stats
    let bodyTypeID: String
    let sold, hasThreeDImage: Bool
    let transmission, fuelType, marketplaceVisibleDate: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "imageUrl"
        case year, city, state, gradeScore, sellingCondition, hasWarranty, marketplacePrice, marketplaceOldPrice, hasFinancing, mileage, mileageUnit, installment, depositReceived, loanValue
        case websiteURL = "websiteUrl"
        case stats
        case bodyTypeID = "bodyTypeId"
        case sold, hasThreeDImage, transmission, fuelType, marketplaceVisibleDate
    }
}

// MARK: - Stats
struct Stats: Codable {
    let webViewCount, webViewerCount, interestCount, testDriveCount: Int
    let appViewCount, appViewerCount, processedLoanCount: Int
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, currentPage, pageSize: Int
}

// MARK: - Welcome
struct ListingsResult: Codable {
    let result: [Listing]
    let pagination: Pagination
}



// MARK: - ListingDetail
struct ListingDetail: Codable {
    // to add more properties later
    let id: String
    let year: Int
    let vin: String
    let imageURL: String
    let carName: String
    let engineType: String
    let fuelType: String
    let marketplacePrice: Int

    enum CodingKeys: String, CodingKey {
        case id, year, vin
        case imageURL = "imageUrl"
        case marketplacePrice
        case carName, fuelType, engineType
    }
}
