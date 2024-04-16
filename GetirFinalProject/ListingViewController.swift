//
//  ListingViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 11.04.24.
//

import UIKit
import SnapKit
import RxSwift
class ListingViewController: UIViewController {
    var collectionView : UICollectionView!
    var activityIndicator: UIActivityIndicatorView!
    var horizontalProducts = [Product]()
    var verticalProducts = [Product]()
    var disposeBag = DisposeBag()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //TEST
        setupActivityIndicator()
        fetchProducts()
       //TEST
        self.navigationItem.title = "Ürünler"
        let basketButton = BasketButton()
        
        basketButton.snp.makeConstraints { make in
            make.width.equalTo(91)
            make.height.equalTo(34)
        }
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: basketButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        configureCollectionView()
        
        
       
    
    }
    
    
    
    
    private func setupActivityIndicator() {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
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
        
     
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                // First section layout (horizontal scrolling)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.20), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(556), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "sectionBackground")
                            backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
                            section.decorationItems = [backgroundDecoration]
            
            
                section.orthogonalScrollingBehavior = .continuous
       
                

                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 8) // Added bottom padding, and top padding for spacing from the
                
                return section
            } else {
                // Second section layout (vertical scrolling with 3 items in a row)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 16)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                //TEST
                let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "sectionBackground")
                            backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
                            section.decorationItems = [backgroundDecoration]
            

                
                
                
                //BAK BURAYA
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0) // Added bottom padding, and top padding for spacing from the navigation controller
                
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
              
              cell.configure(with: product)
              return cell
          }
        

    }



