//
//  ProductService+Extension.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 15.04.24.
//

import Foundation
import Moya

extension ProductService: TargetType {
    
    var baseURL: URL {
        URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api")!
    }
    
    var path: String {
        switch self {
        case .getVerticalProducts:
            return "/products"
        case .getHorizontalProducts:
            return "/suggestedProducts"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
