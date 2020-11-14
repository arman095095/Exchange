//
//  AskBidInteractor.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AskBidBusinessLogic {
    func makeRequest(request: AskBid.Model.Request.RequestType)
}

class AskBidInteractor: AskBidBusinessLogic {
    
    var presenter: AskBidPresentationLogic?
    var service: AskBidService?
    
    func makeRequest(request: AskBid.Model.Request.RequestType) {
        if service == nil {
            service = AskBidService()
        }
        switch request {
        case .getData(currency: let currency,vcType: let vcType):
            service?.get(currency: currency, vcType: vcType) { response, error in
                if let error = error {
                    self.presenter?.presentData(response: .error(error))
                    return
                }
                guard let response = response else { return }
                switch vcType {
                case .askVC:
                    self.presenter?.presentData(response: .presentAsk(response: response, vcType: vcType))
                case .bidVC:
                    self.presenter?.presentData(response: .presentBid(response: response, vcType: vcType))
                case .diffVC:
                    break
                }
                
            }
        case .subscribeSocket(currency: let currency, vcType: let vcType):
            service?.subscribeWebSocket(currency: currency, vcType: vcType, complition: { (response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.presenter?.presentData(response: .error(error))
                    return
                }
                guard let response = response else { return }
                switch vcType {
                case .askVC:
                    self.presenter?.presentData(response: .presentAskSocket(response: response, vcType: vcType))
                case .bidVC:
                    self.presenter?.presentData(response: .presentBidSocket(response: response, vcType: vcType))
                case .diffVC:
                    break
                }
            })
        case .selectNewCurrency:
            presenter?.presentData(response: .presentNewCurrency)
        case .unsubscribeSockt:
            service?.unsubscribeWebSocket()
        }
    }
    
}
