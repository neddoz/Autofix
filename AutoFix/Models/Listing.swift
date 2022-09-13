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
    let bodyTypeID: String
    let sold, hasThreeDImage: Bool
    let transmission, fuelType, marketplaceVisibleDate: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "imageUrl"
        case year, city, state, gradeScore, sellingCondition, hasWarranty, marketplacePrice, marketplaceOldPrice, hasFinancing, mileage, mileageUnit, installment, depositReceived, loanValue
        case websiteURL = "websiteUrl"
        case bodyTypeID = "bodyTypeId"
        case sold, hasThreeDImage, transmission, fuelType, marketplaceVisibleDate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        self.year = try values.decodeIfPresent(Int.self, forKey: .year) ?? 0
        self.city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.state = try values.decodeIfPresent(String.self, forKey: .state) ?? ""
        self.gradeScore = try values.decodeIfPresent(Double.self, forKey: .gradeScore) ?? 0.0
        self.sellingCondition = try values.decodeIfPresent(String.self, forKey: .sellingCondition) ?? ""
        self.hasWarranty = try values.decodeIfPresent(Bool.self, forKey: .hasWarranty) ?? false
        self.marketplacePrice = try values.decodeIfPresent(Int.self, forKey: .marketplacePrice) ?? 0
        self.marketplaceOldPrice = try values.decodeIfPresent(Int.self, forKey: .marketplaceOldPrice) ?? 0
        self.hasFinancing = try values.decodeIfPresent(Bool.self, forKey: .hasFinancing) ?? false
        self.mileage = try values.decodeIfPresent(Int.self, forKey: .mileage) ?? 0
        self.mileageUnit = try values.decodeIfPresent(String.self, forKey: .mileageUnit) ?? ""
        self.installment = try values.decodeIfPresent(Int.self, forKey: .installment) ?? 0
        self.depositReceived = try values.decodeIfPresent(Bool.self, forKey: .depositReceived) ?? false
        self.loanValue = try values.decodeIfPresent(Int.self, forKey: .loanValue) ?? 0
        self.websiteURL = try values.decodeIfPresent(String.self, forKey: .websiteURL) ?? ""
        self.bodyTypeID = try values.decodeIfPresent(String.self, forKey: .bodyTypeID) ?? ""
        self.sold = try values.decodeIfPresent(Bool.self, forKey: .sold) ?? false
        self.hasThreeDImage = try values.decodeIfPresent(Bool.self, forKey: .hasThreeDImage) ?? false
        self.transmission = try values.decodeIfPresent(String.self, forKey: .transmission) ?? ""
        self.fuelType = try values.decodeIfPresent(String.self, forKey: .fuelType) ?? ""
        self.marketplaceVisibleDate = try values.decodeIfPresent(String.self, forKey: .marketplaceVisibleDate) ?? ""

    }
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.year = try values.decodeIfPresent(Int.self, forKey: .year) ?? 0
        self.vin = try values.decodeIfPresent(String.self, forKey: .vin) ?? ""
        self.imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        self.carName = try values.decodeIfPresent(String.self, forKey: .carName) ?? ""
        self.engineType = try values.decodeIfPresent(String.self, forKey: .engineType) ?? ""
        self.fuelType = try values.decodeIfPresent(String.self, forKey: .fuelType) ?? ""
        self.marketplacePrice = try values.decodeIfPresent(Int.self, forKey: .marketplacePrice) ?? 0
    }
}
