//
//  BottomUIView.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 21.04.24.
//

import UIKit
import SnapKit
class BottomUIView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(100)
        }
    }
    
}
