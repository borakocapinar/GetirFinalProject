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
       
                

                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8) // Added bottom padding, and top padding for spacing from the
                
                return section
            } else {
                // Second section layout (vertical scrolling with 3 items in a row)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                //TEST
                let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "sectionBackground")
                            backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
                            section.decorationItems = [backgroundDecoration]
            

                
                
                
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 0) // Added bottom padding, and top padding for spacing from the navigation controller
                
                return section
            }
        }
        //TEST
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: "sectionBackground")
        //TEST
        
       
        
        return layout
    }
}

//TEST
class SectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white // Set the background color to white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//TEST







 //MARK: - UICollectionViewDataSource Extension
    extension ListingViewController: UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 25 // Arbitrary number of items for demonstration
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
    }



