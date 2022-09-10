//
//  HomeViewModel.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {

    var isLoading = BehaviorRelay<Bool>(value: false)
    var items = BehaviorRelay<[ListingCellViewModel]>(value: [])
    var error = BehaviorRelay<Error?>(value: nil)
    var nextItemsLink: String?
    private var resultObject = BehaviorRelay<ListingsResult?>(value: nil)
    private let disposeBag = DisposeBag()

    init(doIntialFetch: Bool = true) {
        if doIntialFetch {
            fetchItems(with: "\"\"")
        }
    }

    func fetchItems(with query: String, client: APIServiceProtocol = APIClient.shared ) {
        let searchRequest: APIRequest = ListingsRequest()
        let observable: Observable<Result<ListingsResult, Error>> = client.send(apiRequest: searchRequest)
        isLoading.accept(true)
        observable.subscribe { result in
            self.isLoading.accept(false)
            switch result {
            case .success(let apiResult):
                let viewModels = apiResult.result.map { ListingCellViewModel($0)}
                let mergedVms = viewModels + self.items.value
                self.items.accept(mergedVms)
                self.resultObject.accept(apiResult)
            case .failure(let error):
                self.error.accept(error)
            }
        } onError: { error in
            self.isLoading.accept(false)
            self.error.accept(error)
        } .disposed(by: disposeBag)
    }
    
    func item(for row: Int)-> ListingCellViewModel {
        return items.value[row]
    }
    
    func numberOfRows()-> Int {
        return items.value.count
    }
}
