//
//  ListingsRequest.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import Foundation
import UIKit

class ListingsRequest: APIRequest {
    var method = RequestType.GET
    var path = "inventory/car/search"
    var parameters = [String: String]()
}

class MakesRequest: APIRequest {
    var method = RequestType.GET
    var path = "inventory/make"
    var parameters = [String: String]()
    
    init() {
        parameters["popular"] = "true"
    }
}
