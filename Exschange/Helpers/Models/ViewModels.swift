//
//  ViewModels.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//

import Foundation

struct CurrencyModel: CurrencyModelType, Hashable {
    var firstCurrency: String
    
    var secondCurrency: String
    
    var currencyText: String {
        return firstCurrency + "/" + secondCurrency
    }
    
    var urlParametr: String {
        return firstCurrency + secondCurrency
    }
}



struct PriceModel: PriceModelType {
    var priceType: PriceType
    
    var amount: String
    
    var price: String
    
    var total: String {
        guard let amountValue = Double(amount),let priceValue = Double(price) else { return "" }
        return String(format: "%.6f", amountValue * priceValue)
    }
    
    var formatedPrice: String {
        guard let form = Double(price) else { return "" }
        return String(format: "%.4f", form)
    }
    
    var formatedAmount: String {
        guard let form = Double(amount) else { return "" }
        return String(format: "%.5f", form)
    }
}
