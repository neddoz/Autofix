//
//  ListingsRequest.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import Foundation

class ListingsRequest: APIRequest {
    var method = RequestType.GET
    var path = "inventory/car/search"
    var parameters = [String: String]()
}
