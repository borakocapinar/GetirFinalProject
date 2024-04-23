//
//  ProductCollectionViewCell.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit
import Kingfisher




class ProductCollectionViewCell: UICollectionViewCell {
    
    
    var productId: String?
    
   
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CustomColor.primarySubtitle.cgColor
        
        
        imageView.image = UIImage(named: "itemIcon")
        return imageView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = CustomFont.openSansBold14
        label.text = "₺0,00"
        label.textColor = CustomColor.getirPurple
        label.numberOfLines = 0
        
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = CustomFont.openSansSemiBold12
        label.text = "Product Name"
        label.textColor = CustomColor.textDark
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = CustomFont.openSansSemiBold12
        label.text = "Attribute"
        label.textColor = CustomColor.textSecondary
        label.numberOfLines = 0
        return label
    }()
    
    lazy var verticalAddToCartbuttonView : testButton = {
        let button = testButton(frame: .zero, axis: .vertical, size: 32)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(nameLabel)
        addSubview(attributeLabel)
        addSubview(verticalAddToCartbuttonView)
        
        
        verticalAddToCartbuttonView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-4)
            make.width.equalTo(32)
            make.right.equalToSuperview().offset(4)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        attributeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            
           
        }
        
        
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
        }
    
    func configure(cartItemCountDelegate: CartItemCountDelegate, updateItemCountDelegate: UpdateItemCountDelegate, product: Product) {
        
        // Set the image using Kingfisher
        if let urlString = product.displayImageURL, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            imageView.image = UIImage(named: "itemIcon")  // Fallback placeholder image
        }

        // Set other properties
        priceLabel.text = product.priceText
        nameLabel.text = product.name
        attributeLabel.text = product.description
        let productId = product.id ?? "0"
        verticalAddToCartbuttonView.cartItemCountDelegate = cartItemCountDelegate
        verticalAddToCartbuttonView.updateItemCountDelegate = updateItemCountDelegate
        let itemCount = cartItemCountDelegate.count(for: productId)
        updateImageViewBorderColor(itemCount: itemCount)
        verticalAddToCartbuttonView.count = itemCount
        verticalAddToCartbuttonView.productId = productId
        verticalAddToCartbuttonView.updateButtonUI()
        
    }
    
    private func updateImageViewBorderColor(itemCount:Int){
        if itemCount == 0{
            imageView.layer.borderColor = CustomColor.primarySubtitle.cgColor
        }
        else {
            imageView.layer.borderColor = CustomColor.getirPurple.cgColor
        }
    }
        
        
    }



