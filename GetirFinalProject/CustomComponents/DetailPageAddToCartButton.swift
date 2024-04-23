//
//  DetailPageAddToCartButton.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 21.04.24.
//

import UIKit

class DetailPageAddToCartButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupButton() {
        titleLabel?.font = CustomFont.openSansBold14
        setTitle("Sepete Ekle", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = CustomColor.getirPurple
        layer.cornerRadius = 12
    }
}
