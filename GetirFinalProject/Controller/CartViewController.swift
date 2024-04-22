//
//  CartViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
   
    
    
    var tableView: UITableView!
    weak var listingViewControllerDelegate: ListingViewControllerDelegate?
    weak var cartItemCountDelegate : CartItemCountDelegate?
    private var products: [Product] = []{
        didSet{
            if products.count == 0{
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProducts()
        view.backgroundColor = CustomColor.listingPageBackground
        setupNavigationBar()
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartTableViewCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        
       
        
        

    }
    private func setupProducts() {
            products = listingViewControllerDelegate?.fetchProductsInCart() ?? []
            
        }
    
    private func setupNavigationBar(){
        self.navigationItem.title = "Sepetim"
        let navbarTrashButton = UIBarButtonItem(image: UIImage(named: "navbarTrashIcon"), style: .plain, target: self, action: #selector(navbarTrashButtonTapped))
        navbarTrashButton.tintColor = .white
        navigationItem.rightBarButtonItem = navbarTrashButton
        
        let customBackButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        customBackButton.tintColor = .white
        navigationItem.leftBarButtonItem = customBackButton
        
    }
    
    
    @objc func navbarTrashButtonTapped(){
        cartItemCountDelegate?.removeAllItems()
        products = []
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension CartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
        let product = products[indexPath.row]
        cell.configure(cartItemCountdelegate: cartItemCountDelegate!, trashButtonDelegate: self, product: product)
            return cell
    }
    

    
}

extension CartViewController: TrashButtonDelegate{
    func trashButtonDidPress(productId: String) {
        products = products.filter { $0.id != productId }
        tableView.reloadData()
    }
    
    
}


    

