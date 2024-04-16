//
//  tryUIViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 12.04.24.
//

import UIKit
import SnapKit
import RxSwift

class tryUIViewController: UIViewController {
    var disposeBag = DisposeBag()
    var products = [Product]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        let testButton = VerticalAddToCartButtonView()
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            
            
            fetchHorizontalProducts()
        }
        
        
        
    
        
        
    }
    
    func fetchHorizontalProducts() {
           ProductNetworkManager.shared.fetchHorizontalProducts { [weak self] (products, error) in
               if let error = error {
                   print("Error fetching horizontal products: \(error)")
                   return
               }
               //TODO Handle fetched Items
               self?.handleHorizontalProducts(products: products!)
           }
       }
    
    func handleHorizontalProducts(products: [Product]){
        print(products)
    }
                   
                      
        
           }
        
        
        
        
    
    
    
    
    

