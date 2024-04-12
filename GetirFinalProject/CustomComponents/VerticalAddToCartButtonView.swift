//
//  VerticalAddToCartButtonUiView.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 12.04.24.
//

import UIKit
import SnapKit

class VerticalAddToCartButtonView: UIView {

      private let addButton: UIButton
       private let countLabel: UILabel
       private let trashButton: UIButton
       
       private var count: Int = 0 {
           didSet {
               countLabel.text = "\(count)"
           }
       }
       
       override init(frame: CGRect) {
           addButton = UIButton(type: .system)
           countLabel = UILabel()
           trashButton = UIButton(type: .system)
           super.init(frame: frame)
           self.setupAddButton()
           self.setupCountLabel()
           self.setupTrashButton()
           setCornerRadius()
           
           
          
           
           
       }
    
    private func setCornerRadius(){
                layer.cornerRadius = 8
                layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                clipsToBounds = true
    }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func setupAddButton(){
        addButton.backgroundColor = .systemPink
        addButton.setImage(UIImage(named: "plusIcon"), for: .normal)
        addButton.addTarget(self, action: #selector(handleAddTap), for: .touchUpInside)
        addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.left.right.equalToSuperview()
                    make.height.equalTo(32)
                }
    }
    
    private func setupCountLabel(){
        countLabel.backgroundColor = .systemPink
        countLabel.textAlignment = .center
        countLabel.isHidden = true // Hide initially
        addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
                  make.top.equalTo(addButton.snp.bottom)
                  make.left.right.equalToSuperview()
                  make.height.equalTo(32).priority(.high)
              }
    }
    
    private func setupTrashButton(){
        trashButton.backgroundColor = .systemPink
         trashButton.setImage(UIImage(named: "trashIcon"), for: .normal)
         trashButton.addTarget(self, action: #selector(handleTrashTap), for: .touchUpInside)
         trashButton.isHidden = true // Hide initially
         addSubview(trashButton)
        
        
        trashButton.snp.makeConstraints { make in
                    make.top.equalTo(countLabel.snp.bottom)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(32)
                    make.bottom.equalToSuperview()
                }
    }
    
   
    
       
       @objc private func handleAddTap() {
           count += 1
           if countLabel.isHidden {
               // Expand the view to show the counter and trash button
               UIView.animate(withDuration: 0.3) {
                   self.countLabel.isHidden = false
                   self.trashButton.isHidden = false
                   
               }
           }
       }
       
       @objc private func handleTrashTap() {
           count = 0
           self.countLabel.isHidden = true
           self.trashButton.isHidden = true
           
       }
   }

    
    

