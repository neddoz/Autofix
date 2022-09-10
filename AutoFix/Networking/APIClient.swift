//
//  APIClient.swift
//  AutoFix
//
//  Created by kayeli dennis on 09/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

public protocol APIServiceProtocol {
    static var shared: APIServiceProtocol {get}
    func send<T: Codable>(apiRequest: APIRequest)-> Observable<Result<T, Error>>
}


final class APIClient: APIServiceProtocol {
    
    static let instance = APIClient()
    
    static var shared: APIServiceProtocol {
        return APIClient.instance
    }

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<Result<T, Error>> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.response(request: request).map {
            if $0.response.status != .success {
                if $0.response.status == .notFound {
                    return .failure(NetworkError.NotFound(errorMessage: request.url?.absoluteString ?? ""))
                } else {
                    return .failure(NetworkError.other)
                }
            }
            do {
                let decoder = JSONDecoder()
                return .success(try decoder.decode(T.self, from: $0.data))
            } catch {
                return .failure(NetworkError.DecodingFailure(errorMessage: error.localizedDescription))
            }
        }.share(replay: 1, scope: SubjectLifetimeScope.forever)
    }
    
    // MARK: - Private methods

    private let baseURL = URL(string: "https://api-prod.autochek.africa/v1/")!
}
