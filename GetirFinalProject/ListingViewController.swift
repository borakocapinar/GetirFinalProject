//
//  ListingViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit
class ListingViewController: UIViewController {
    
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.navigationItem.title = "Ürünler"
        //delete
        let basketButton = BasketButton()
        
        basketButton.snp.makeConstraints { make in
            make.width.equalTo(91)
            make.height.equalTo(34)
        }
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: basketButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        
        
        
        
        
    }
    
    @objc func basketButtonTapped() {
        print("Button tapped")
    }
    
    //MARK: - TRY COMPOSITIONAL LAYOUT
    
    
}
