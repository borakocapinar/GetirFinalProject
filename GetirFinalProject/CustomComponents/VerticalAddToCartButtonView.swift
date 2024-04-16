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
       private let removeButton: UIButton

       
       private var count: Int = 0 {
           didSet {
               countLabel.text = "\(count)"
           }
       }
       
       override init(frame: CGRect) {
           addButton = UIButton(type: .system)
           countLabel = UILabel()
           trashButton = UIButton(type: .system)
           removeButton = UIButton(type: .system)
           super.init(frame: frame)
           self.setupAddButton()
           self.setupCountLabel()
           self.setupTrashButton()
           self.setupRemoveButton()
           setCornerRadius()
           configureShadow()
           
       }
    
 
    
    private func setCornerRadius(){
                layer.cornerRadius = 8
                layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                clipsToBounds = true
    }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func setAddButtonRadius(){
        addButton.layer.cornerRadius = 8
    }
    
    private func resetAddButtonRadius(){
        addButton.layer.cornerRadius = 0
        setCornerRadius()
    }
    
    private func setupAddButton(){
        addButton.backgroundColor = .white
        addButton.setImage(UIImage(named: "plusIcon"), for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        setAddButtonRadius()
        addButton.addTarget(self, action: #selector(handleAddTap), for: .touchUpInside)
        addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.left.right.equalToSuperview()
                    make.height.equalTo(32)
            make.width.equalTo(addButton.snp.height)
                    
                }
    }
    
    
    
    private func setupCountLabel(){
        countLabel.backgroundColor = CustomColor.getirPurple
        countLabel.font = CustomFont.openSansBold
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.isHidden = true // Hide initially
        addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
                  make.top.equalTo(addButton.snp.bottom)
                  make.left.right.equalToSuperview()
            make.height.equalTo(32).priority(.high)
            make.width.equalTo(countLabel.snp.height)
                  
              }
    }
    
    private func setupTrashButton(){
        trashButton.backgroundColor = .white
         trashButton.setImage(UIImage(named: "trashIcon"), for: .normal)
         trashButton.addTarget(self, action: #selector(handleTrashTap), for: .touchUpInside)
         trashButton.isHidden = true // Hide initially
         addSubview(trashButton)
        
        
        trashButton.snp.makeConstraints { make in
                    make.top.equalTo(countLabel.snp.bottom)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(32)
            make.width.equalTo(trashButton.snp.height)
                    make.bottom.equalToSuperview()

                   
                }
    }
    
    private func setupRemoveButton(){
        removeButton.backgroundColor = .white
        removeButton.setImage(UIImage(named: "removeIcon"), for: .normal)
        removeButton.addTarget(self, action: #selector(handleRemoveTap), for: .touchUpInside)
        removeButton.isHidden = true
        addSubview(removeButton)
        
        removeButton.snp.makeConstraints { make in
                    make.top.equalTo(countLabel.snp.bottom)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(32)
            make.width.equalTo(removeButton.snp.height)
            make.bottom.equalToSuperview()
                    
                }
    }
    
    private func configureShadow() {
            layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowRadius = 3
            
            
            let spread: CGFloat = -1
            if spread != 0 {
                let dx = -spread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                layer.shadowPath = UIBezierPath(rect: rect).cgPath
            } else {
                layer.shadowPath = nil
            }

            layer.masksToBounds = false
        }
   
    
       
       @objc private func handleAddTap() {
           resetAddButtonRadius()
           print("add")
           count += 1
           if countLabel.isHidden{
               countLabel.isHidden = false
               trashButton.isHidden = false
           }
           if count > 1 {
               trashButton.isHidden = true
               removeButton.isHidden = false
           }
           
       }
    
    @objc private func handleRemoveTap() {
        print("remove")
        count -= 1
        
        if count == 1 {
            removeButton.isHidden = true
            trashButton.isHidden = false
        }
    }
       
       @objc private func handleTrashTap() {
           setAddButtonRadius()
           count = 0
           self.countLabel.isHidden = true
           self.trashButton.isHidden = true
           
       }
   }

    
    

