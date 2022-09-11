//
//  ListingDetailViewModel.swift
//  AutoFix
//
//  Created by kayeli dennis on 11/09/2022.
//

import RxSwift
import RxRelay

struct InfoItem {
    let key: String
    let value: String
}

class ListingDetailViewModel {

    var listingImageURl: URL {
        guard let url = URL(string: item.value?.imageURL ?? "") else {
            return URL(string: "")!
        }
        return url
    }
    
    var title: String {
        return item.value?.carName ?? ""
    }
    
    var infoItems = BehaviorRelay<[InfoItem]>(value: [])
    var error = BehaviorRelay<Error?>(value: nil)
    var imageURL = BehaviorRelay<URL?>(value: nil)

    init(carId: String, client: APIServiceProtocol = APIClient.shared) {
        
        let searchRequest: APIRequest = ListingDetailRequest(carId)
        let observable: Observable<Result<ListingDetail, Error>> = client.send(apiRequest: searchRequest)
        
        observable.asObservable().subscribe { [weak self] result in
            guard let self = `self` else {return}
            switch result {
            case .success(let detail):
                
                self.item.accept(detail)
                var items: [InfoItem] = []
                // build infoItems, we can have a builder for this
                
                items.append(InfoItem(key: "VIN", value: detail.vin))
                items.append(InfoItem(key: "Engine Type", value: detail.engineType))
                items.append(InfoItem(key: "Fuel Type", value: detail.fuelType))
                items.append(InfoItem(key: "Vehicle Id", value: detail.id))
                if let price = self.decimalFormatter.string(from: NSNumber(value: detail.marketplacePrice)) {
                    items.append(InfoItem(key: "Price", value: "Ksh " + price))
                }
                
                self.infoItems.accept(items)
                
                if let url = URL(string: detail.imageURL) {
                    self.imageURL.accept(url)
                }
            case .failure(let error):
                self.error.accept(error)
            }
        } onError: {[weak self] error in
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }

    private let item = BehaviorRelay<ListingDetail?>(value: nil)
    private let disposeBag = DisposeBag()
    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        return formatter
    }()
}
