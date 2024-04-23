//
//  ProceedToCheckoutButton.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 22.04.24.
//

import UIKit

class ProceedToCheckoutButton: UIButton {

       private var textLabel: UILabel!
        private var priceLabel: UILabel!
        private var titleView: UIView!
        private var priceView: UIView!
    
     init() {
         super.init(frame: .zero)
         setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupButton() {
            layer.cornerRadius = 12
            layer.cornerRadius = 8
            clipsToBounds = true
            
            setupTitleView()
            setupPriceView()
            
            titleView.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(priceView.snp.left)
            }
            
            priceView.snp.makeConstraints { make in
                make.right.top.bottom.equalToSuperview()
                make.left.equalTo(titleView.snp.right)
                
                priceView.isUserInteractionEnabled = false
                titleView.isUserInteractionEnabled = false
                
            }
        }
    
    private func setupTitleView() {
            titleView = UIView()
        titleView.backgroundColor = CustomColor.getirPurple
        addSubview(titleView)
        titleView.layer.cornerRadius = super.layer.cornerRadius
        titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
            textLabel = UILabel()
            textLabel.text = "Siparişi Tamamla"
            textLabel.font = CustomFont.openSansBold14
            textLabel.textColor = .white
            textLabel.textAlignment = .center
            titleView.addSubview(textLabel)
            
            textLabel.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
        }
    
    private func setupPriceView() {
           priceView = UIView()
           priceView.backgroundColor = .white
           addSubview(priceView)
        priceView.layer.cornerRadius = super.layer.cornerRadius
        priceView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
           
           priceLabel = UILabel()
          priceLabel.textColor = CustomColor.getirPurple
          priceLabel.font = CustomFont.openSansBold20
           priceLabel.textAlignment = .center
           priceView.addSubview(priceLabel)
           priceLabel.text = "₺1.500,00"
           
           priceLabel.snp.makeConstraints { make in
               make.right.left.equalToSuperview().inset(12)
               make.centerY.equalToSuperview()
           }
       }
    
    func setPriceLabel(price: Double){
        let formattedPrice = String(format: "₺%.2f", price)
        priceLabel.text = formattedPrice
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
