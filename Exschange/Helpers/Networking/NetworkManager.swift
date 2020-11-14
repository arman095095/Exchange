//
//  NetworkManager.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//



import Foundation

class NetworkManager {
    
    func getData(urlPath:String,complition: @escaping (ResponseModel?,Error?) -> ()) {
        guard let url = getFullURL(name: urlPath) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(nil,error)
                return
            }
            guard let data = data else {
                complition(nil,nil)
                return
            }
            guard let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: data) else {
                complition(nil,nil)
                return }
            complition(responseModel,nil)
        }.resume()
    }
    
    private func getFullURL(name:String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.binance.com"
        urlComponents.path = "/api/v3/ticker/24hr"
       
        let items = ["symbol":"\(name)"]
        urlComponents.queryItems = items.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }
}
