//
//  ProductCollectionViewCell.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit

import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    
    
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 16
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = CustomColor.primarySubtitle.cgColor

        //Test
        imageView.image = UIImage(named: "sampleItem")
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
            return label
        }()
        
        lazy var attributeLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = CustomFont.openSansSemiBold
            label.text = "Attribute"
            label.textColor = CustomColor.textSecondary
            return label
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
            }
            
            attributeLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(2)
                make.leading.equalTo(imageView.snp.leading)
            }
        }
    
    
}
