//
//  SocketManager.swift
//  TestNEWSocket
//
//  Created by Arman Davidoff on 27.10.2020.
//

import UIKit
import Starscream

//"wss://stream.binance.com:9443/ws/btcusdt@bookTicker"

class SocketManager {
    
    static let shared = SocketManager()
    private var socket: WebSocket?
    weak var delegate: WebSocketDelegate?
    
    private init() {  }
   
    func startListeningSocket(with parametr: String) {
        if socket != nil { socket!.disconnect() }
        var request = URLRequest(url: URL(string: "wss://stream.binance.com:9443/ws/\(parametr)@bookTicker")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self.delegate
        socket?.connect()
    }
    
    func socketDisconnect() {
        if socket != nil { socket!.disconnect() }
    }
    
    func appEnterBackground() {
        socketDisconnect()
    }
    
    func appEnterForGround() {
        socket?.connect()
    }
}

