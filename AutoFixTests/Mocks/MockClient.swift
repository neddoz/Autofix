//
//  MockClient.swift
//  AutoFixTests
//
//  Created by kayeli dennis on 11/09/2022.
//

import Foundation
import RxSwift


var sampleListingJSON = """
{
    "id": "5",
    "title": "someTitle",
    "imageURL": "example.com",
    "year": 2014,
    "city": "Nairobi",
    "state": "Nairobi",
    "gradeScore": 4.0,
    "sellingCondition": "foreighn",
    "hasWarranty": false,
    "marketplacePrice": 1459000,
    "marketplaceOldPrice": 23455666,
    "hasFinancing": false,
    "mileage": 123456,
    "mileageUnit": "km",
    "installment": 1,
    "depositReceived": false,
    "loanValue": 456789,
    "websiteURL": "example.com",
    "bodyTypeID": "suv",
    "sold": false,
    "hasThreeDImage": false,
    "transmission": "AWD",
    "fuelType": "diesel",
    "transmission": "AWD",
    "marketplaceVisibleDate": "20149540"
}
"""

var sampleListingJDetailSON = """
{
    "id": "5",
    "year": 2014,
    "vin": "jsngo",
    "imageURL": "example.com",
    "city": "Nairobi",
    "state": "Nairobi",
    "gradeScore": 4.0,
    "carName": "BMW",
    "engineType": "diesel",
    "fuelType": "diesel",
    "marketplacePrice": 2094929
}
"""

enum mockScenario {
    case listings
    case listingDetail
}

class MockClient: APIServiceProtocol {

    var mockSuccess: Bool = false
    var mockScenario: mockScenario = .listings
    
    func getsampleListing()-> Listing {
        let jsonData = sampleListingJSON.data(using: .utf8)!
        let listing: Listing = try! JSONDecoder().decode(Listing.self, from: jsonData)
        return listing
    }
    
    func getSampleListingDetail()-> ListingDetail {
        let jsonData = sampleListingJDetailSON.data(using: .utf8)!
        let detail: ListingDetail = try! JSONDecoder().decode(ListingDetail.self, from: jsonData)
        return detail
    }
    
    func getSampleSearchResult()-> ListingsResult {
        return .init(result: [getsampleListing()], pagination: Pagination(total: 1, currentPage: 1, pageSize: 1))
    }
    
    func getSampleListindDetailResult()-> ListingDetail {
        return getSampleListingDetail()
    }
}

extension MockClient {
    static var shared: APIServiceProtocol {
        return MockClient()
    }
    
    func send<T>(apiRequest: APIRequest) -> Observable<Result<T, Error>> where T : Decodable, T : Encodable {

        if apiRequest is MakesRequest {
            return Observable.just(.success(Make.init(id: 4, name: "BNW", imageURL: "") as! T))
        }
        
        if apiRequest is ListingDetailRequest {
            return Observable.just(.success( getSampleListingDetail() as! T))
        }
        
        if mockSuccess {
            switch mockScenario {
            case .listings:
                return Observable.just(.success(getSampleSearchResult() as! T))
            case .listingDetail:
                return Observable.just(.success(getSampleListingDetail() as! T))
            }
        } else {
            return Observable.just(.failure(NetworkError.DecodingFailure(errorMessage: "Failed to decode")))
        }
    }
}
