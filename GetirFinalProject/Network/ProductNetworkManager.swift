//
//  ProductNetworkManager.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 15.04.24.
//

import RxSwift
import RxMoya
import Moya
import Foundation

struct ProductNetworkManager {
   
    
    private let provider = MoyaProvider<ProductService>()


    static let shared = ProductNetworkManager()

    
    
    func fetchProducts(service: ProductService) -> Single<[Product]> {
            return provider.rx.request(service)
                .map { response in
                    let results = try JSONDecoder().decode([WelcomeElement].self, from: response.data)
                    return results.flatMap { $0.products ?? [] }
                }
                .catch { error in
                    throw error
                }
        }
    
    
    
    
    
    
        }
    
    
