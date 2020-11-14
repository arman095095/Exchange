//
//  AskBidWorker.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Starscream

class AskBidService {
    
    var networkManager = NetworkManager()
    lazy var socketManager = SocketManager.shared
    var isConnected = false
    var complitionForSocket: ((SocketResponseModel?,Error?)->())?
    
    func get(currency: CurrencyModel,vcType: VCType,complition:@escaping (ResponseModel?,Error?)->()) {
        networkManager.getData(urlPath: currency.urlParametr) { (responseModel, error) in
            if let error = error {
                complition(nil,error)
                return
            }
            guard let response = responseModel else { return }
            complition(response,nil)
        }
    }
    
    func subscribeWebSocket(currency: CurrencyModel,vcType: VCType,complition:@escaping (SocketResponseModel?,Error?)->()) {
        let parametr = currency.urlParametr.lowercased()
        complitionForSocket = complition
        socketManager.delegate = self
        socketManager.startListeningSocket(with: parametr)
    }
    
    func unsubscribeWebSocket() {
        socketManager.socketDisconnect()
    }
}


extension AskBidService: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            guard let responseModel = decode(dataString: string) else { return }
            complitionForSocket?(responseModel,nil)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        complitionForSocket?(nil,error)
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    private func decode(dataString:String) -> SocketResponseModel? {
        guard let data = dataString.data(using: .utf8) else { return nil }
        guard let responseModel = try? JSONDecoder().decode(SocketResponseModel.self, from: data) else { return nil }
        return responseModel
    }
}

