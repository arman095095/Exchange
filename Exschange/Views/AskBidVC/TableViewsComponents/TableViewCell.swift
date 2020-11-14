//
//  TableViewCell.swift
//  Exschange
//
//  Created by Arman Davidoff on 26.10.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    var amountLabel = UILabel()
    var priceLabel = UILabel()
    var totalLabel = UILabel()
    var stackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: PriceModelType) {
        amountLabel.text = model.formatedAmount
        priceLabel.text = model.formatedPrice
        totalLabel.text = model.total
        switch model.priceType {
        case .bid:
            priceLabel.textColor = VCType.bidVC.color
        case .ask:
            priceLabel.textColor = VCType.askVC.color
        }
    }
}

extension TableViewCell {
    func setupViews() {
        stackView = UIStackView(arrangedSubviews: [amountLabel,priceLabel,totalLabel])
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8).isActive = true
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        priceLabel.textAlignment = .center
        totalLabel.textAlignment = .right
        
    }
}
