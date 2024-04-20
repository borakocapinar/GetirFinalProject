//
//  CartViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit

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
               tableView.translatesAutoresizingMaskIntoConstraints = false
               tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
               tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
               tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
               tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
            cell.mockConfigure()
            return cell
    }
    
    
}
