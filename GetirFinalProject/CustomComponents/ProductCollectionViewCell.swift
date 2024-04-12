//
//  ProductCollectionViewCell.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit

import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    let fontBold = UIFont(name: "OpenSans-Bold", size: 14)
    let fontSemiBold = UIFont(name: "OpenSans-SemiBold", size: 12)
    
    
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 16
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1.0).cgColor

        //Test
        imageView.image = UIImage(named: "sampleItem")
            return imageView
        }()
        
        lazy var priceLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = fontBold
            label.text = "₺0,00"
            label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0)

            return label
        }()
        
        lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = fontSemiBold
            label.text = "Product Name"
            label.textColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
            return label
        }()
        
        lazy var attributeLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = fontSemiBold
            label.text = "Attribute"
            label.textColor = UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 1.0)
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
