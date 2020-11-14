//
//  HeaderView.swift
//  Exschange
//
//  Created by Arman Davidoff on 26.10.2020.
//

import UIKit


class HeaderView: UITableViewHeaderFooterView {

    static let identifier = "header"
    
    var amountLabel = UILabel()
    var priceLabel = UILabel()
    var totalLabel = UILabel()
    var stackView: UIStackView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(currency: CurrencyModel) {
        
        self.amountLabel.text = "Amount \(currency.firstCurrency)"
        self.priceLabel.text = "Price \(currency.secondCurrency)"
        self.totalLabel.text = "Total"
    }
    
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
        priceLabel.textColor = .gray
        totalLabel.textColor = .gray
        amountLabel.textColor = .gray
        if #available(iOS 14.0, *) {
            backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        } else {
            // Fallback on earlier versions
        }
    }

}
