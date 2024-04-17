//
//  ProductCollectionViewCell.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit
import Kingfisher


protocol ProductCollectionViewCellDelegate: AnyObject {
    func getCount(for productId: String) -> Int
    func updateCount(for productId: String, count: Int)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ProductCollectionViewCellDelegate?
    var productId: String?
    
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
        label.numberOfLines = 0
        
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = CustomFont.openSansSemiBold
        label.text = "Product Name"
        label.textColor = CustomColor.textDark
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
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
    
    func configure(with product: Product) {
        
        // Assuming productId is already a property of this cell
            productId = product.id
            
//            // Get the current count for the product from the delegate
//            let currentCount = delegate?.getCount(for: product.id ?? "0") ?? 0
//            verticalAddToCartbuttonView.count = currentCount

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
                imageView.image = UIImage(named: "itemIcon")  // Fallback placeholder image
            }
            
            // Set other properties
            priceLabel.text = product.priceText ?? "₺\(product.price ?? 0.00)"
            nameLabel.text = product.name ?? ""
            attributeLabel.text = product.description ?? ""
//
//            // Configure the block to handle changes in the count
//            verticalAddToCartbuttonView.onCountChanged = { [weak self] newCount in
//                guard let self = self, let productId = self.productId else { return }
//                self.delegate?.updateCount(for: productId, count: newCount)
            }
        
        
    }

