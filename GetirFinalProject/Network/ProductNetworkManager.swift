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

    
    
    private func fetchProducts(service: ProductService, completion: @escaping ([Product]?, Error?) -> Void) {
           provider.request(service) { result in
               switch result {
               case .success(let response):
                   do {
                       let results = try JSONDecoder().decode([WelcomeElement].self, from: response.data)
                       let products = results.flatMap { $0.products ?? [] }
                       completion(products, nil)
                   } catch {
                       print("Error decoding: \(error)")
                       completion(nil, error)
                   }
               case .failure(let error):
                   print("Error requesting data: \(error)")
                   completion(nil, error)
               }
           }
       }
    
    // Public method to fetch horizontal products.
    func fetchHorizontalProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        fetchProducts(service: .getHorizontalProducts, completion: completion)
    }

    // Public method to fetch vertical products.
    func fetchVerticalProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        fetchProducts(service: .getVerticalProducts, completion: completion)
    }
    
    
    
    
        }
    
    

