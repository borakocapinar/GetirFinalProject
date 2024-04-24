//
//  CartButton.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit

class CartButton: UIButton {
    
    private var label: UILabel!
    private var labelView: UIView!
    private var buttonImageView: UIView!
    
    init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupButton() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        setupLabelView()
        setupImageView()
        
        snp.makeConstraints { make in
            make.right.equalTo(labelView.snp.right) 
            make.left.equalTo(buttonImageView.snp.left)
            make.top.equalTo(labelView.snp.top)
            make.bottom.equalTo(labelView.snp.bottom)
        }
    }
    
    
    
    
    
    private func setupLabelView(){
        // Create a view for the label
        labelView = UIView()
        labelView.backgroundColor = CustomColor.primarySubtitle
        labelView.layer.cornerRadius = super.layer.cornerRadius
        labelView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        labelView.isUserInteractionEnabled = false
        
        label = UILabel()
        label.text = "₺0,00"
        label.font = CustomFont.openSansBold14
        label.textColor = CustomColor.getirPurple
        label.textAlignment = .center
        labelView.addSubview(label)
        
        self.addSubview(labelView)
        
        
        labelView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 7, bottom: 10, right: 7))
        }
    }
    
    private func setupImageView(){
        buttonImageView = UIView()
        buttonImageView.backgroundColor = .white
        buttonImageView.layer.cornerRadius = super.layer.cornerRadius
        buttonImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        buttonImageView.layer.masksToBounds = true
        buttonImageView.isUserInteractionEnabled = false
        
        
        let image = UIImageView(image: UIImage(named: "basketIcon"))
        image.contentMode = .center
        buttonImageView.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        self.addSubview(buttonImageView)
        
        buttonImageView.snp.makeConstraints { make in
            make.right.equalTo(labelView.snp.left)
            make.height.equalTo(labelView.snp.height)
            
        }
        
    }
    
    func setCartLabel(price: Double){
        if let formattedPrice = NumberFormatter.turkishLiraFormatter.string(from: NSNumber(value: price)) {
            label.text = formattedPrice
        } else {
            label.text = "₺0,00"
        }
    }
    
    
    
    
    //MARK: - Button Animation
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateButtonDown()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateButtonUp()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateButtonUp()
    }
    
    private func animateButtonDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func animateButtonUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    
}
