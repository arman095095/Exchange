//
//  CustomButton.swift
//  Exschange
//
//  Created by Arman Davidoff on 26.10.2020.
//

import UIKit

class CurrencyButton: UIButton {
    
    var currencyLabel = UILabel()
    var buttonImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    func config(currencyName:String) {
        currencyLabel.text = currencyName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func setupSubviews() {
        
        self.addSubview(buttonImageView)
        self.addSubview(currencyLabel)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonImageView.image = UIImage(systemName: "control")
        buttonImageView.tintColor = .gray
        buttonImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        buttonImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        buttonImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        buttonImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        buttonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 5).isActive = true
        
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        currencyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        backgroundColor = .systemGray6
    }
}
