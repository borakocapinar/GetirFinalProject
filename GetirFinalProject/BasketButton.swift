//
//  BasketButton.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit

class BasketButton: UIButton {

    
   
    init() {
        super.init(frame: .zero)
        setupButton()
        bringSubviewToFront(self)
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          

    private func setupButton() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        setupImageView()
        setupLabelView()
        }
    
    private func setupImageView(){
        let imageView = UIView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = super.layer.cornerRadius
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = false
        
        
        let image = UIImageView(image: UIImage(named: "basketIcon"))
        imageView.addSubview(image)
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            
            make.width.equalTo(34)
        }
    }
    
    private func setupLabelView(){
        // Create a view for the label
        let labelView = UIView()
        labelView.backgroundColor = UIColor(red: 242.0/255.0, green: 240.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        labelView.layer.cornerRadius = super.layer.cornerRadius
        labelView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        labelView.isUserInteractionEnabled = false
        
        let label = UILabel()
        label.text = "₺0,00"
        guard let font = UIFont(name: "OpenSans-Bold", size: 14.0) else{return}
        label.font = font
        label.textColor = UIColor(red: 93.0/255.0, green: 62.0/255.0, blue: 188.0/255.0, alpha: 1.0)
        label.textAlignment = .center
        labelView.addSubview(label)
        
        self.addSubview(labelView)
        
        
        labelView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(57)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(37)
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
