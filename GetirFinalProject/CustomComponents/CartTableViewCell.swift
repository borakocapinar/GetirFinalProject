//
//  CartTableViewCell.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 19.04.24.
//

import UIKit
import SnapKit
import Kingfisher

class CartTableViewCell: UITableViewCell {

    // UI Components
    private let horizontalStackView = UIStackView()
    private let itemImageView = UIImageView()
    private let verticalStackView = UIStackView()
    private let nameLabel = UILabel()
    private let attributeLabel = UILabel()
    private let priceLabel = UILabel()
    private let horizontalAddToCartButton = testButton(frame: .zero, axis: .horizontal, size: 32)

    // Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mockConfigure()
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Setup the views
    private func setupViews() {
        // Configure the horizontal stack view
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 16
        contentView.addSubview(horizontalStackView)

        // Configure the image view
        itemImageView.layer.cornerRadius = 16
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.layer.borderWidth = 1
        itemImageView.layer.borderColor = CustomColor.primarySubtitle.cgColor
        horizontalStackView.addArrangedSubview(itemImageView)
        
       

        // Configure the vertical stack view
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        horizontalStackView.addArrangedSubview(verticalStackView)

        // Add labels to the vertical stack view
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(attributeLabel)
        verticalStackView.addArrangedSubview(priceLabel)

        verticalStackView.setCustomSpacing(4, after: nameLabel)
        verticalStackView.setCustomSpacing(2, after: attributeLabel)

        // Add the custom view
        contentView.addSubview(horizontalAddToCartButton)
    }

    // Setup constraints using SnapKit
    private func setupConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(12)
            make.right.equalTo(horizontalAddToCartButton.snp.left).offset(8)
        }

        itemImageView.snp.makeConstraints { make in
            make.width.height.equalTo(72)
        }

        horizontalAddToCartButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        
    }
    
    func mockConfigure(){
        itemImageView.image = UIImage(named: "itemIcon")

        nameLabel.text = "Product Name"
        nameLabel.font = CustomFont.openSansSemiBold12
        nameLabel.textColor = CustomColor.textDark
        nameLabel.numberOfLines = 0
        
        attributeLabel.text = "Attribute"
        attributeLabel.font = CustomFont.openSansSemiBold12
        attributeLabel.textColor = CustomColor.textSecondary
        
        priceLabel.text = "₺0,00"
        priceLabel.font = CustomFont.openSansBold14
        priceLabel.textColor = CustomColor.getirPurple
    }
    
    
    func configure(withDelegate delegate: CartItemCountDelegate, product: Product) {
        
        // Set the image using Kingfisher
        if let urlString = product.displayImageURL, let url = URL(string: urlString) {
            itemImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            itemImageView.image = UIImage(named: "itemIcon")  // Fallback placeholder image
        }

        // Set other properties
        priceLabel.text = product.priceText
        nameLabel.text = product.name
        attributeLabel.text = product.description
        let productId = product.id ?? "0"
        horizontalAddToCartButton.cartItemCountDelegate = delegate
        horizontalAddToCartButton.count = delegate.count(for: productId)
        horizontalAddToCartButton.productId = productId
        horizontalAddToCartButton.updateButtonUI()
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            horizontalAddToCartButton.cartItemCountDelegate = nil
        }
    
    
}
