//
//  ListingViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit
import RxSwift

protocol ListingViewControllerDelegate: AnyObject {
    func fetchHorizontalProducts() -> [Product]
    func fetchVerticalProducts() -> [Product]
}


protocol CartItemCountDelegate: AnyObject {
    func incrementItemCount(for productId: String)
    func decrementItemCount(for productId: String)
    func removeItem(for productId: String)
    func count(for productId: String) -> Int
}



class ListingViewController: UIViewController {
    weak var delegate: ListingViewControllerDelegate?
    var collectionView : UICollectionView!
    var activityIndicator: UIActivityIndicatorView!
    var horizontalProducts = [Product]()
    var verticalProducts = [Product]()
    var disposeBag = DisposeBag()
    
    
    var totalPrice: Double = 0.0
       
    var itemCounts: [String: Int] = [:] {
        didSet {
            calculateTotalPrice()
            updateBasketButton()
        }
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        fetchProducts()
        configureCollectionView()
        setupNavigationBar()
        self.view.bringSubviewToFront(activityIndicator)

    }
    
    
    
    
    private func setupNavigationBar(){
        self.navigationItem.title = "Ürünler"
        let basketButton = BasketButton()
        
       
        
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        basketButton.isHidden = true
       

        let rightBarButtonItem = UIBarButtonItem(customView: basketButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
   
    
    
    private func updateBasketButton() {
        guard let basketButton = self.navigationItem.rightBarButtonItem?.customView as? BasketButton else {
            return
        }
        
        basketButton.isHidden = totalPrice > 0.0 ? false : true
        
        basketButton.setCartLabel(price: totalPrice)
    }
    
    
    private func calculateTotalPrice() {
        totalPrice = 0.0

        for (productId, quantity) in itemCounts {
            if let product = (horizontalProducts + verticalProducts).first(where: { $0.id == productId }) {
                totalPrice += Double(quantity) * (product.price ?? 0)
            }
        }
    }

    
    
    
    
    
    
    
    
    private func setupActivityIndicator() {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
        activityIndicator.color = .black
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            

    }
    
    @objc func basketButtonTapped() {
        print("Button tapped")
       
    }
    
    //MARK: - Compositional Layout
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = CustomColor.listingPageBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        // Register cell classes
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
     
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                // First section layout (horizontal scrolling)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3) ,heightDimension: .estimated(220))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "sectionBackground")
                            backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
                            section.decorationItems = [backgroundDecoration]
            
            
                section.orthogonalScrollingBehavior = .continuous
       
                

                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 8) 
                
                return section
            } else {
                // Second section layout (vertical scrolling with 3 items in a row)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1) ,heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                //TEST
                let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "sectionBackground")
                            backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
                            section.decorationItems = [backgroundDecoration]
            

                
                
                
                //BAK BURAYA
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0)
                
                return section
            }
        }
        
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: "sectionBackground")
        
        
       
        
        return layout
    }
    
    //TEST
    
    private func fetchProducts() {
        let verticalObservable = ProductNetworkManager.shared.fetchProducts(service: .getVerticalProducts).asObservable()
        let horizontalObservable = ProductNetworkManager.shared.fetchProducts(service: .getHorizontalProducts).asObservable()

        Observable.zip(verticalObservable, horizontalObservable) { (verticalProducts, horizontalProducts) -> (vertical: [Product], horizontal: [Product]) in
            return (vertical: verticalProducts, horizontal: horizontalProducts)
        }
        .subscribe(onNext: { [weak self] fetchedProducts in
            self?.verticalProducts = fetchedProducts.vertical
            self?.horizontalProducts = fetchedProducts.horizontal
            DispatchQueue.main.async { // Ensure UI updates are on the main thread
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }, onError: { error in
            print("Error fetching products: \(error)")
        })
        .disposed(by: disposeBag)
    }

    
    
    
    
    
    //TEST
    
    

   
   
    
    
}


class SectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white // Set the background color to white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








 //MARK: - UICollectionViewDataSource Extension
    extension ListingViewController: UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch section {
                   case 0:
                return horizontalProducts.count
                   case 1:
                return verticalProducts.count
                   default:
                       return 0
                   }
         
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionViewCell
              
              // Determine the correct array based on the section
              let product = (indexPath.section == 0) ? horizontalProducts[indexPath.item] : verticalProducts[indexPath.item]
              
              
              cell.configure(withDelegate: self, product: product)
              return cell
          }
        

    }

//MARK: - UICollectionViewDelegate Extension

extension ListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = (indexPath.section == 0) ? horizontalProducts[indexPath.item] : verticalProducts[indexPath.item]
        
        let detailVC = ProductDetailViewController()
        detailVC.product = product  
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - ListingViewControllerDelegate Extension

extension ListingViewController: ListingViewControllerDelegate {
    func fetchHorizontalProducts() -> [Product] {
        return horizontalProducts
    }

    func fetchVerticalProducts() -> [Product] {
        return verticalProducts
    }
}

//MARK: - CartItemCountDelegate Extension
extension ListingViewController: CartItemCountDelegate {
    func incrementItemCount(for productId: String) {
        itemCounts[productId, default: 0] += 1
    }

    func decrementItemCount(for productId: String) {
        let currentCount = itemCounts[productId, default: 0]
        if currentCount > 1 {
            itemCounts[productId] = currentCount - 1
        } else {
            itemCounts.removeValue(forKey: productId)
        }
    }

    func removeItem(for productId: String) {
        itemCounts.removeValue(forKey: productId)
    }

    func count(for productId: String) -> Int {
        return itemCounts[productId, default: 0]
    }
}







