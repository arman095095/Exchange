//
//  Protocols.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//

import UIKit

protocol PresentTableViewProtocol: class {
    func addToSubview(_ view: UIView)
    func didSelect(currencyModel: CurrencyModel)
}

protocol CurrencyModelType {
    var firstCurrency: String { get set }
    var secondCurrency: String { get set }
    var currencyText:String { get }
}

protocol PriceModelType {
    var formatedAmount: String { get }
    var formatedPrice: String { get }
    var total: String { get }
    var priceType: PriceType { get }
}

