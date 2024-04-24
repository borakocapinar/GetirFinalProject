//
//  Product.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 15.04.24.
//

import Foundation

struct WelcomeElement: Codable {
    let products: [Product]?
}


struct Product: Codable {
    let id: String?
    let imageURL: String?
    let price: Double?
    let name: String?
    let priceText: String?
    let shortDescription: String?
    let squareThumbnailURL: String?
    let attribute: String?
    
    
    var displayImageURL: String? {
        return imageURL?.convertHTTPtoHTTPS() ?? squareThumbnailURL?.convertHTTPtoHTTPS()
    }
    
    var description: String? {
        return shortDescription ?? attribute
    }
    
    init(id: String? = nil, imageURL: String? = nil, price: Double? = nil, name: String? = nil, priceText: String? = nil, shortDescription: String? = nil, squareThumbnailURL: String? = nil, attribute: String? = nil) {
        self.id = id
        self.imageURL = imageURL
        self.price = price
        self.name = name
        self.priceText = priceText
        self.shortDescription = shortDescription
        self.squareThumbnailURL = squareThumbnailURL
        self.attribute = attribute
    }
    
}

extension String {
    func convertHTTPtoHTTPS() -> String {
        if self.hasPrefix("http://") {
            return self.replacingOccurrences(of: "http://", with: "https://")
        }
        return self
    }
}


