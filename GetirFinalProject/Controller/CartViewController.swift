//
//  CartViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import SnapKit
import UIKit

class CartViewController: UIViewController {
    
    var tableView: UITableView!
    private let bottomUIView = BottomUIView()
    private let proceedToCheckoutButton = ProceedToCheckoutButton()
    weak var listingViewControllerDelegate: ListingViewControllerDelegate?
    weak var cartItemCountDelegate: CartItemCountDelegate?
    private var totalPrice = 0.0
    private var products: [Product] = [] {
        didSet {
            if products.count == 0 {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private var itemCounts: [String: Int] = [:] {
        didSet {
            calculateTotalPrice()
            updateProceedToCheckOutButtonPriceLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProducts()
        view.backgroundColor = CustomColor.listingPageBackground
        setupNavigationBar()
        setItemCounts()
        setupBottomView()
        setupTableView()
    }
    
    private func setItemCounts() {
        itemCounts = cartItemCountDelegate?.getItemCounts() ?? [:]
    }
    
    private func calculateTotalPrice() {
        totalPrice = 0
        for (productId, count) in itemCounts {
            if let product = products.first(where: { $0.id == productId }) {
                totalPrice += Double(count) * (product.price ?? 0)
            }
        }
    }
    
    private func setupProducts() {
        products = listingViewControllerDelegate?.fetchProductsInCart() ?? []
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Sepetim"
        let navbarTrashButton = UIBarButtonItem(
            image: UIImage(named: "navbarTrashIcon"), style: .plain, target: self,
            action: #selector(navbarTrashButtonTapped))
        navbarTrashButton.tintColor = .white
        navigationItem.rightBarButtonItem = navbarTrashButton
        
        let customBackButton = UIBarButtonItem(
            image: UIImage(named: "backIcon"), style: .plain, target: self,
            action: #selector(backButtonTapped))
        customBackButton.tintColor = .white
        navigationItem.leftBarButtonItem = customBackButton
        
    }
    
    @objc func navbarTrashButtonTapped() {
        cartItemCountDelegate?.removeAllItems()
        products = []
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartTableViewCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalTo(bottomUIView.snp.top)
        }
    }
    
    private func setupBottomView() {
        view.addSubview(bottomUIView)
        
        bottomUIView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        setupProceedToCheckoutButton()
        
    }
    
    private func setupProceedToCheckoutButton() {
        proceedToCheckoutButton.addTarget(
            self, action: #selector(proceedToCheckoutButtonTapped), for: .touchUpInside)
        bottomUIView.addSubview(proceedToCheckoutButton)
        
        proceedToCheckoutButton.setPriceLabel(price: totalPrice)
        
        proceedToCheckoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
    }
    
    private func updateProceedToCheckOutButtonPriceLabel() {
        proceedToCheckoutButton.setPriceLabel(price: totalPrice)
    }
    
    //MARK: - SuccessMessage Popup
    private func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 100
        self.view.addSubview(blurEffectView)
    }
    
    private func removeBlurEffect() {
        if let blurEffectView = self.view.viewWithTag(100) {
            blurEffectView.removeFromSuperview()
        }
    }
    
    private func disableNavigationBarButtons() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.isEnabled = false
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func proceedToCheckoutButtonTapped() {
        disableNavigationBarButtons()
        
        let successPopup = SuccessMessageView()
        
        successPopup.onOkButtonPressed = { [weak self] in
            self?.removeBlurEffect()
            
            self?.navigationController?.popToRootViewController(animated: true)
            
            self?.cartItemCountDelegate?.removeAllItems()
            self?.products = []
        }
        
        setBlurEffect()
        successPopup.show(in: self.view, totalPrice: String(totalPrice))
        
    }
    
    
    
}

//MARK: - UITableViewDataSource Extension

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath)
        as! CartTableViewCell
        let product = products[indexPath.row]
        cell.configure(
            cartItemCountdelegate: cartItemCountDelegate!, trashButtonDelegate: self,
            updateItemCountDelegate: self, product: product)
        return cell
    }
    
}

//MARK: - TrashButtonDelegate Extension
extension CartViewController: TrashButtonDelegate {
    func trashButtonDidPress(productId: String) {
        products = products.filter { $0.id != productId }
        tableView.reloadData()
    }
}

//MARK: - UpdateItemCountDelegate Extension
extension CartViewController: UpdateItemCountDelegate {
    func updateItemCounts() {
        setItemCounts()
    }
    
}
