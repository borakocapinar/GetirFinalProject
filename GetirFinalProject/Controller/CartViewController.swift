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


    override func viewDidLoad() {
        super.viewDidLoad()
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
        print("Trash Button Tapped!")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension CartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
            
            return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 72
//    }
    
    
}
