//
//  ProductDetailViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    
    var product: Product!
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    private let priceLabel = UILabel()
    private let nameLabel = UILabel()
    private let attributeLabel = UILabel()
    private let bottomUIView = BottomUIView()
    private let detailPageAddToCartButton = DetailPageAddToCartButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.listingPageBackground
        setupBottomView()
        setupNavigationBar()
        setupViews()
        setupLabels()
        setupConstraints()
        configureWithProduct(product)
    }
    
    private func setupNavigationBar(){
        self.navigationItem.title = "Ürün Detayı"
        let customBackButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        customBackButton.tintColor = .white
        navigationItem.leftBarButtonItem = customBackButton
        
        
    }
    
    private func setupBottomView(){
        view.addSubview(bottomUIView)
        
        bottomUIView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        setupDetailPageAddToCartButton()
    }
    
    private func setupDetailPageAddToCartButton(){
        detailPageAddToCartButton.addTarget(self, action: #selector(detailPageAddToCartButtonTapped), for: .touchUpInside)
        
        bottomUIView.addSubview(detailPageAddToCartButton)
    
        detailPageAddToCartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func detailPageAddToCartButtonTapped(){
        print("Button Tapped")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
            // Setting up the container view
            view.addSubview(containerView)
            containerView.backgroundColor = .white

            containerView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit

            setupStackView()
        }

        private func setupStackView() {
            containerView.addSubview(stackView)
            stackView.axis = .vertical
            stackView.alignment = .center
            

            stackView.addArrangedSubview(priceLabel)
            stackView.addArrangedSubview(nameLabel)
            stackView.addArrangedSubview(attributeLabel)
            stackView.setCustomSpacing(4, after: priceLabel)
            stackView.setCustomSpacing(2, after: nameLabel)
        }

        private func setupConstraints() {
            containerView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.width.equalToSuperview()

                   make.height.greaterThanOrEqualTo(350).priority(.high) // Minimum height
                make.height.equalToSuperview().multipliedBy(0.40).priority(.medium)
            }
            
            imageView.snp.makeConstraints { make in
                make.top.equalTo(containerView.snp.top).offset(16)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(200)
            }
            
            stackView.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(16)
                make.right.left.equalToSuperview().inset(16)
                make.centerX.equalToSuperview()
            }
           

        }
    
        private func setupLabels(){
            priceLabel.font = CustomFont.openSansBold20
            priceLabel.textColor = CustomColor.getirPurple
            priceLabel.numberOfLines = 1
            
          
            
            nameLabel.font = CustomFont.openSansSemiBold16
            nameLabel.textColor = CustomColor.textDark
            nameLabel.numberOfLines = 0
            nameLabel.textAlignment = .center
            nameLabel.adjustsFontSizeToFitWidth = true
            nameLabel.minimumScaleFactor = 0.5
            
             
            
            attributeLabel.font = CustomFont.openSansSemiBold12
            attributeLabel.textColor = CustomColor.textSecondary
            
            
        
            
        }
        
        func configureWithProduct(_ product: Product) {
           if let urlString = product.displayImageURL, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            imageView.image = UIImage(named: "itemIcon")
        }
            priceLabel.text = product.priceText
            nameLabel.text = product.name
            attributeLabel.text = product.description
        }
    
   
    
}
