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
        
        
        configureCollectionView()
    
    }
    
    @objc func basketButtonTapped() {
        print("Button tapped")
    }
    
    //MARK: - Compositional Layout
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
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
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(556), heightDimension: .estimated(185))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8)
                return section
            } else {
                // Second section layout (vertical scrolling with 3 items in a row)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8)
                
              
                
                return section
            }
        }
        return layout
    }
}
 //MARK: - UICollectionViewDataSource Extension
    extension ListingViewController: UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10 // Arbitrary number of items for demonstration
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//            cell.backgroundColor = .systemPurple // Set a background color to see the cell
            return cell
        }
    }

