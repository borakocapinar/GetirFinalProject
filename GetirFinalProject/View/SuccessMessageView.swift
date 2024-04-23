//
//  SuccessMessageView.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 23.04.24.
//

import UIKit

final class SuccessMessageView: UIView {
    private let imageView = UIImageView()
    private let messageLabel = UILabel()
    private let okButton = UIButton()
    private let subtitleLabel = UILabel()
    var onOkButtonPressed: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupView() {
        configureAppearance()
        setupConstraints()
    }
    
    private func configureAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 10)
        
        setupImageView()
        setupMessageLabel()
        setupSubtitleLabel()
        setupOkbutton()
    }
    
    private func setupImageView() {
        let tickImage = UIImage(named: "success")
        imageView.image = tickImage
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    private func setupMessageLabel() {
        messageLabel.text = "Checkout Successful!"
        messageLabel.textAlignment = .center
        addSubview(messageLabel)
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .gray
        addSubview(subtitleLabel)
    }
    
    private func setupOkbutton() {
        okButton.setTitle("OK", for: .normal)
        okButton.backgroundColor = UIColor.systemBlue
        okButton.layer.cornerRadius = 8
        okButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        addSubview(okButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    @objc private func dismissPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            self.removeFromSuperview()
            self.onOkButtonPressed?()
        }
    }
    
    func show(in view: UIView, totalPrice: String) {
        prepareToShow(in: view)
        subtitleLabel.text = "Total Price: \(totalPrice)"
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    private func prepareToShow(in view: UIView) {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 300)
        self.center = view.center
        view.addSubview(self)
    }
}
