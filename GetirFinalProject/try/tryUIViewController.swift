//
//  tryUIViewController.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 12.04.24.
//

import UIKit
import SnapKit

class tryUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        
        let testButton = VerticalAddToCartButtonView()
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
    }
    

   

}
