//
//  VerticalAddToCartButtonUiView.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 12.04.24.
//

import UIKit
import SnapKit

class AddToCartButton: UIView {

       weak var cartItemCountDelegate: CartItemCountDelegate?
       private let addButton: UIButton
       private let countLabel: UILabel
       private let trashButton: UIButton
       private let removeButton: UIButton
    private let stackView: UIStackView = UIStackView()
       var productId: String? = "0"
       
        var count: Int = 0 {
           didSet {
               countLabel.text = "\(count)"
           }
       }
       
        init(frame: CGRect, axis: NSLayoutConstraint.Axis) {
            addButton = UIButton(type: .system)
            countLabel = UILabel()
            trashButton = UIButton(type: .system)
            removeButton = UIButton(type: .system)
            super.init(frame: frame)
            setupStackView(axis: axis) // Setup the stack view with the specified axis
            setCornerRadius()
            configureShadow()
            
           
       }
    
    private func setupStackView(axis: NSLayoutConstraint.Axis) {
            stackView.axis = axis
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            addSubview(addButton)
        
            if axis == .horizontal {
                // Order for horizontal: removeButton, countLabel, addButton
    
                addButton.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.right.bottom.equalToSuperview()
                }
                
                stackView.addArrangedSubview(removeButton)
                stackView.addArrangedSubview(trashButton) 
                stackView.addArrangedSubview(countLabel)
                
                addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.top.bottom.left.equalToSuperview()
                make.right.equalTo(addButton.snp.left)
                
            }
            
            } else {
                // Order for vertical: addButton, countLabel, removeButton
                
                    addButton.snp.makeConstraints { make in
                        make.top.equalToSuperview()
                        make.right.left.equalToSuperview()
                    }
                    
                    stackView.addArrangedSubview(countLabel)
                    stackView.addArrangedSubview(removeButton)
                    stackView.addArrangedSubview(trashButton)
                    
                    addSubview(stackView)
                
                    stackView.snp.makeConstraints { make in
                    make.top.equalTo(addButton.snp.bottom)
                    make.right.left.equalToSuperview()
                    make.bottom.equalToSuperview()
                }

            }
        
            setupAddButton()
            setupCountLabel()
            setupRemoveButton()
            setupTrashButton()
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
        addButton.backgroundColor = .white
        addButton.setImage(UIImage(named: "plusIcon"), for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        setAddButtonRadius()
        addButton.addTarget(self, action: #selector(handleAddTap), for: .touchUpInside)
        
        addButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            
        }
        
    }
    
    
    private func setupCountLabel(){
        countLabel.backgroundColor = CustomColor.getirPurple
        countLabel.font = CustomFont.openSansBold14
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.isHidden = true // Hide initially
        
        countLabel.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
    }
    
    private func setupTrashButton(){
        trashButton.backgroundColor = .white
         trashButton.setImage(UIImage(named: "trashIcon"), for: .normal)
         trashButton.addTarget(self, action: #selector(handleTrashTap), for: .touchUpInside)
         trashButton.isHidden = true // Hide initially
        
        trashButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
       
    }
    
    private func setupRemoveButton(){
        removeButton.backgroundColor = .white
        removeButton.setImage(UIImage(named: "removeIcon"), for: .normal)
        removeButton.addTarget(self, action: #selector(handleRemoveTap), for: .touchUpInside)
        removeButton.isHidden = true
        
        removeButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
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

        if let productId = productId, let delegate = cartItemCountDelegate {
                   delegate.incrementItemCount(for: productId)
                   count = delegate.count(for: productId)
               }
        updateButtonUI()
    }

    @objc private func handleRemoveTap() {
        if let productId = productId, let delegate = cartItemCountDelegate {
                   delegate.decrementItemCount(for: productId)
                   count = delegate.count(for: productId)
               }
        updateButtonUI()
    }

    @objc private func handleTrashTap() {

        if let productId = productId, let delegate = cartItemCountDelegate {
                   delegate.removeItem(for: productId)
                   count = delegate.count(for: productId)
               }
        updateButtonUI()
    }

    
    func updateButtonUI(){
        updateVisibility()
        if countLabel.isHidden && trashButton.isHidden && removeButton.isHidden{
            setAddButtonRadius()
        }
        else{
            resetAddButtonRadius()
        }
    }
     private func updateVisibility() {
        countLabel.isHidden = count == 0
        trashButton.isHidden = count <= 0 || count > 1
        removeButton.isHidden = count <= 1
    }
    
    private func setAddButtonRadius(){
        addButton.layer.cornerRadius = 8
    }
    
    private func resetAddButtonRadius(){
        addButton.layer.cornerRadius = 0
        setCornerRadius()
    }
    
   }

    
    

