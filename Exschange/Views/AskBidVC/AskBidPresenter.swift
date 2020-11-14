//
//  AskBidPresenter.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AskBidPresentationLogic {
    func presentData(response: AskBid.Model.Response.ResponseType)
}

class AskBidPresenter: AskBidPresentationLogic {
    weak var viewController: AskBidDisplayLogic?
    
    func presentData(response: AskBid.Model.Response.ResponseType) {
        switch response {
        case .presentAsk(response: let response,vcType: let vcType):
            let viewModel = convertToAskViewModel(from: response, vcType: vcType)
            viewController?.displayData(viewModel: .displayModel(model: viewModel))
        case .presentBid(response: let response, vcType: let vcType):
            let viewModel = convertToBidViewModel(from: response, vcType: vcType)
            viewController?.displayData(viewModel: .displayModel(model: viewModel))
        case .error(let error):
            print(error.localizedDescription)
        case .presentBidSocket(response: let response, vcType: let vcType):
            let viewModel = convertToBidViewModel(from: response, vcType: vcType)
            viewController?.displayData(viewModel: .displayModel(model: viewModel))
        case .presentAskSocket(response: let response, vcType: let vcType):
            let viewModel = convertToAskViewModel(from: response, vcType: vcType)
            viewController?.displayData(viewModel: .displayModel(model: viewModel))
        case .presentNewCurrency:
            viewController?.displayData(viewModel: .displayNewCurrency)
        }
    }
    
    private func convertToBidViewModel(from response: ResponseModel,vcType:VCType) -> PriceModelType {
        var priceType: PriceType!
        switch vcType {
        case .askVC:
            priceType = .ask
        case .bidVC:
            priceType = .bid
        case .diffVC:
            break
        }
        return PriceModel(priceType: priceType, amount: response.bidQty, price: response.bidPrice)
    }
    
    private func convertToAskViewModel(from response: ResponseModel,vcType:VCType) -> PriceModelType {
        var priceType: PriceType!
        
        switch vcType {
        case .askVC:
            priceType = .ask
        case .bidVC:
            priceType = .bid
        case .diffVC:
            break
        }
        return PriceModel(priceType: priceType, amount: response.askQty, price: response.askPrice)
    }
    
    private func convertToAskViewModel(from response: SocketResponseModel,vcType:VCType) -> PriceModelType {
        var priceType: PriceType!
        switch vcType {
        case .askVC:
            priceType = .ask
        case .bidVC:
            priceType = .bid
        case .diffVC:
            break
        }
        return PriceModel(priceType: priceType, amount: response.A, price: response.a)
    
    }
    
    private func convertToBidViewModel(from response: SocketResponseModel,vcType:VCType) -> PriceModelType {
        var priceType: PriceType!
        switch vcType {
        case .askVC:
            priceType = .ask
        case .bidVC:
            priceType = .bid
        case .diffVC:
            break
        }
        return PriceModel(priceType: priceType, amount: response.B, price: response.b)
    }
    
}
