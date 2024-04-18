//
//  CartManager.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 18.04.24.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    private init() {}

    var itemCounts: [String: Int] = [:]

    func incrementItemCount(for productId: String) {
        itemCounts[productId, default: 0] += 1
    }

    func decrementItemCount(for productId: String) {
        let currentCount = itemCounts[productId, default: 0]
        if currentCount > 1 {
            itemCounts[productId] = currentCount - 1
        } else {
            itemCounts.removeValue(forKey: productId)
        }
    }

    func removeItem(for productId: String) {
        itemCounts.removeValue(forKey: productId)
    }

    func count(for productId: String) -> Int {
        return itemCounts[productId, default: 0]
    }
}
