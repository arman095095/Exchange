//
//  OtherModels.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//

import UIKit

enum PriceType {
    case bid
    case ask
}

enum VCType: String {
    case askVC = "Info:Ask"
    case bidVC = "Info:Bid"
    case diffVC = "Details"
    
    var imageName: String {
        switch self {
        case .bidVC:
            return "plus.circle.fill"
        case .askVC:
            return "minus.circle.fill"
        case .diffVC:
            return "info.circle.fill"
        }
    }
    
    var color: UIColor {
        switch self {
        case .askVC:
            return .red
        case .bidVC:
            return .systemGreen
        case .diffVC:
            return .systemBlue
        }
    }
}
