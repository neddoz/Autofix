//
//  ListingCellViewModel.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import Foundation

class ListingCellViewModel {

    // Variables

    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        return formatter
    }()
    
    var title: NSAttributedString {
        return NSMutableAttributedString().bold(item.title)
    }
    
    var price: String {
        guard let price = decimalFormatter.string(from: NSNumber(value: item.marketplacePrice)) else {
            return ""
        }
        return "Ksh " + price
    }
    
    var mileage: String {
        guard let mileage = decimalFormatter.string(from: NSNumber(value: item.mileage)) else {
            return ""
        }
        return  "\(mileage) km"
    }
    
    var yearOfManufucture: String {
        return String(item.year)
    }
    
    var reviewsRating: String {
        return String(format: "%.1f", item.gradeScore)
    }
    
    var location: String {
        return item.city + "," + item.state
    }
    
    var usage: String {
        return item.sellingCondition
    }
    
    var iconURL: URL {
        return URL(string: item.imageURL) ?? URL(string: "")!
    }

    var listingID: String {
        return item.id
    }

    init(_ item: Listing) {
        self.item = item
    }
    
    private let item: Listing
}
