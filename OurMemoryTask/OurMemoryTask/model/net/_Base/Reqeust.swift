//
//  Reqeust.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
    
    var name: String {
        return self.rawValue
    }
}

enum NetworError: Error {
    case invalidURL
    case notFound
}

enum RequestParam {
    case body([String: Any?])
    case url([String: Any?])
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: RequestParam { get }
    var format: String? { get }
    var headers: [String]? { get }
}

extension Request {
    var method: HTTPMethod { return .get }
    var format: String? { return "application/json" }
    var headers: [String]? { return ["Content-Type", "Accept"] }
    
    func urlRequest() -> URLRequest? {
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        
        // method
        request.httpMethod = method.name
        // header
        headers?.forEach { headerField in
            request.setValue(format, forHTTPHeaderField: headerField)
        }
        // params
        switch params {
        case .body(let params):
            let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
            if let data = bodyData {
                print("request \(params) in body =================>")
                request.httpBody = data
            }
        case .url(let params):
            let queryParams = params.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            var components = URLComponents(string: path)
            components?.queryItems = queryParams
            print("request \(params) in url =================>")
            request.url = components?.url
        }
        return request
    }
}
