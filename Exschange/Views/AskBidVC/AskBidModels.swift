//
//  AskBidModels.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum AskBid {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getData(currency: CurrencyModel,vcType: VCType)
                case subscribeSocket(currency: CurrencyModel,vcType: VCType)
                case unsubscribeSockt
                case selectNewCurrency
            }
        }
        struct Response {
            enum ResponseType {
                case presentBid(response: ResponseModel,vcType: VCType)
                case presentAsk(response: ResponseModel,vcType: VCType)
                case presentBidSocket(response: SocketResponseModel,vcType: VCType)
                case presentAskSocket(response: SocketResponseModel,vcType: VCType)
                case presentNewCurrency
                case error(Error)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayModel(model:PriceModelType)
                case displayNewCurrency
            }
        }
    }
    
}
