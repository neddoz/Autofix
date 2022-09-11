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
    private var makeList = BehaviorRelay<Makes?>(value: nil)

    private let disposeBag = DisposeBag()

    init(doIntialFetch: Bool = true) {
        if doIntialFetch {
            fetchItems(with: "\"\""){ _ in}
        }
    }

    func fetchItems(with query: String, client: APIServiceProtocol = APIClient.shared, completion: @escaping (Bool)-> Void) {
        let searchRequest: APIRequest = ListingsRequest()
        let observable: Observable<Result<ListingsResult, Error>> = client.send(apiRequest: searchRequest)
        
        let request: APIRequest = MakesRequest()
        let makeObservable: Observable<Result<Makes, Error>> = APIClient.shared.send(apiRequest: request)
        
        isLoading.accept(true)
        
        Observable.zip(observable, makeObservable).asObservable().subscribe { [weak self] listingsResult, makesResult in
            guard let self = `self` else {return}
            self.isLoading.accept(false)
            switch (listingsResult, makesResult) {

            case (.success(let listingsresult), .success(let makesResult)):
                let viewModels = listingsresult.result.map { ListingCellViewModel($0)}
                self.makeList.accept(makesResult)
                let mergedVms = viewModels + self.items.value
                self.items.accept(mergedVms)
                self.resultObject.accept(listingsresult)
            case (.failure(let error), .success(let makesResult)):
                self.makeList.accept(makesResult)
                self.error.accept(error)
            case (.success(let listingsresult), .failure(let error)):
                let viewModels = listingsresult.result.map { ListingCellViewModel($0)}
                let mergedVms = viewModels + self.items.value
                self.items.accept(mergedVms)
                self.resultObject.accept(listingsresult)
                self.error.accept(error)
            case (.failure(let error), .failure(_)):
                self.error.accept(error)
            }
            completion(true)

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
    
    func numberOFMakes()-> Int {
        return makeList.value?.makeList.count ?? 0
    }

    func make(at index: Int)-> Make? {
        guard let items = makeList.value?.makeList else { return nil}
        return items[index]
    }
}
