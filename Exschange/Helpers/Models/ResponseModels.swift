//
//  Models.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//

import UIKit

struct ResponseModel:Decodable {
    var bidPrice: String
    var bidQty: String
    var askPrice: String
    var askQty: String
}

struct SocketResponseModel:Decodable {
    var b: String //bid price
    var B: String //bid qty
    var a: String //ask price
    var A: String //ask qty
}
