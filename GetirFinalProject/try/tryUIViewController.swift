////
////  tryUIViewController.swift
////  GetirFinalProject
////
////  Created by BORA KOCAPINAR on 12.04.24.
////
//
//import UIKit
//import SnapKit
//import RxSwift
//
//class tryUIViewController: UIViewController {
//    
//    var products = BehaviorSubject<[Product]>(value: [])
//    var disposeBag = DisposeBag()
//
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .systemBackground
//        
//        
//        let testButton = VerticalAddToCartButtonView()
//        view.addSubview(testButton)
//        
//        testButton.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            
//            
//            fetchHorizontalProducts()
//        }
//        
//        
//        
//    
//        
//        
//    }
//    
//    func fetchHorizontalProducts() {
//        ProductNetworkManager.shared.fetchProducts(service: .getVerticalProducts)
//                    .subscribe(onNext: { [weak self] products in
//                        guard let self = self else { return }
//                        self.products.onNext(products)  // Update BehaviorSubject
//                        self.handleHorizontalProducts(products: products)
//                    }, onError: { error in
//                        print(error.localizedDescription)
//                    }, onCompleted: {
//                        print("Completed fetching products")
//                    }, onDisposed: {
//                        print("Disposed")
//                    })
//                    .disposed(by: disposeBag)
//       }
//    
//    func handleHorizontalProducts(products: [Product]){
//        
//        print(products)
//    }
//                   
//                      
//        
//           }
//        
//        
//        
//        
//    
//    
//    
//    
//    
//
