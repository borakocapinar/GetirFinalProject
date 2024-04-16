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
    
    
    
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 16
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = CustomColor.primarySubtitle.cgColor

        //Test
        imageView.image = UIImage(named: "itemIcon")
            return imageView
        }()
        
        lazy var priceLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = CustomFont.openSansBold
            label.text = "₺0,00"
            label.textColor = CustomColor.getirPurple
            

            return label
        }()
        
        lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = CustomFont.openSansSemiBold
            label.text = "Product Name"
            label.textColor = CustomColor.textDark
            label.numberOfLines = 0
            return label
        }()
        
        lazy var attributeLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = CustomFont.openSansSemiBold
            label.text = "Attribute"
            label.textColor = CustomColor.textSecondary
            label.numberOfLines = 0
            return label
        }()
    
    lazy var verticalAddToCartbuttonView : VerticalAddToCartButtonView = {
       let button = VerticalAddToCartButtonView()
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
                make.top.equalTo(imageView.snp.bottom).offset(8)
                make.leading.equalTo(imageView.snp.leading)
            }
            
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(priceLabel.snp.bottom).offset(2)
                make.leading.equalTo(imageView.snp.leading)
                make.trailing.equalTo(imageView.snp.trailing)
            }
            
            attributeLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(2)
                make.leading.equalTo(imageView.snp.leading)
                
            }
            
           
        }
    
    func configure(with product: Product) {
        // Set the image using Kingfisher
        if let urlString = product.displayImageURL, let url = URL(string: urlString) {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .transition(.fade(0.2)),  // Fade transition with duration of 0.2 seconds
                    .cacheOriginalImage  // Cache the original image
                ])
        } else {
            imageView.image = UIImage(named: "placeholder")  // Fallback placeholder image
        }
        
        // Set other properties
        priceLabel.text = product.priceText ?? "₺\(product.price ?? 0.00)"
        nameLabel.text = product.name ?? "Unknown Product"
        attributeLabel.text = product.description ?? "No Description Available"
    }
    
    
}
