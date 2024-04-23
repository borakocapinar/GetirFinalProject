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
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.listingPageBackground
        let proceedToCheckoutButton = ProceedToCheckoutButton()
        
        view.addSubview(proceedToCheckoutButton)
        
        proceedToCheckoutButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.right.left.equalToSuperview().inset(12)
        }
        
        
        
        }
        
        
    
    
        
        
    }
   
             
                      
        
           
        
        
        
        
    
    
    
    
    

