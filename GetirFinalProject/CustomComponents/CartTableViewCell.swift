//
//  CartTableViewCell.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 19.04.24.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    private lazy var iconImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.layer.borderWidth = 1
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()
       
       private lazy var nameLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
           label.textColor = .black
           return label
       }()
       
       private lazy var detailLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14, weight: .light)
           label.textColor = .gray
           return label
       }()
       
       private lazy var priceLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
           label.textColor = .blue
           return label
       }()
       
       private lazy var actionButtonContainer: UIView = {
           let view = UIView()
           return view
       }()
       
       private lazy var actionButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Action", for: .normal)
           button.backgroundColor = .systemBlue
           button.setTitleColor(.white, for: .normal)
           button.layer.cornerRadius = 8
           return button
       }()
       
       // MARK: - Initialization
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupViews()
           setupConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       // MARK: - Setup
       private func setupViews() {
           addSubview(iconImageView)
           addSubview(actionButtonContainer)
           actionButtonContainer.addSubview(actionButton)
           
           let stackView = UIStackView(arrangedSubviews: [nameLabel, detailLabel, priceLabel])
           stackView.axis = .vertical
           stackView.spacing = 8
           addSubview(stackView)
       }
       
       private func setupConstraints() {
           iconImageView.snp.makeConstraints { make in
               make.left.equalToSuperview().offset(16)
               make.centerY.equalToSuperview()
               make.size.equalTo(CGSize(width: 72, height: 72))
           }
           
           let stackView = subviews.first(where: { $0 is UIStackView }) as! UIStackView
           stackView.snp.makeConstraints { make in
               make.left.equalTo(iconImageView.snp.right).offset(12)
               make.centerY.equalToSuperview()
           }
           
           actionButtonContainer.snp.makeConstraints { make in
               make.left.equalTo(stackView.snp.right).offset(12)
               make.centerY.equalToSuperview()
               make.right.equalToSuperview().offset(-16)
           }
           
           actionButton.snp.makeConstraints { make in
               make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
           }
       }
       
       // MARK: - Configuration
       func configure(with image: UIImage?, name: String, detail: String, price: String) {
           iconImageView.image = image
           nameLabel.text = name
           detailLabel.text = detail
           priceLabel.text = price
       }
    
    func mockConfigure() {
        // Using an empty image (you might use a placeholder or default image in a real app)
        iconImageView.image = UIImage() // Assuming no image provided, creates an empty UIImage

        // Setting up placeholder texts to see the alignment and formatting
        nameLabel.text = "Product Name"
        detailLabel.text = "Some detail about the product here."
        priceLabel.text = "₺100.00"

        // Setting up the action button (if any specific text or action is needed for testing)
        actionButton.setTitle("Buy Now", for: .normal)
    }

}
