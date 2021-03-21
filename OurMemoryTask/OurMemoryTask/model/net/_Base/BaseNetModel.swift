//
//  BaseNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import Foundation

class BaseNetModel {

    let session = URLSession.shared
    
    struct dataRequest : Request {
        let standardURL = "http://13.125.146.53/"
        let session = URLSession.shared
        var method: HTTPMethod
        var params: RequestParam
        var path: String
        
        init(method:HTTPMethod,path: String, param: RequestParam) {
            self.method = method
            self.path = self.standardURL + path
            self.params = param
        }
    }
    
    func reqeustRestFulApi<T: Codable>(method:HTTPMethod,path:String, params:RequestParam ,completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = dataRequest(method: method, path: path, param: params).urlRequest()?.url else { return }
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(T.self, from: responseData)
                completion(.success(response))
            } catch {
                print("---> err: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
   
}
