//
//  FakeData.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//

import Foundation


extension CurrencyModel {
    static func getLocalValues() -> [CurrencyModel] {
        return [CurrencyModel(firstCurrency: "BTC", secondCurrency: "USDT"),CurrencyModel(firstCurrency: "BNB", secondCurrency: "BTC"),CurrencyModel(firstCurrency: "ETH", secondCurrency: "BTC")]
    }
}

