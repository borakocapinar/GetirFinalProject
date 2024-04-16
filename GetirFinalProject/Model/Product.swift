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
        return imageURL ?? squareThumbnailURL
    }
    
    var description: String? {
        return shortDescription ?? attribute
    }
    
    
    
}


