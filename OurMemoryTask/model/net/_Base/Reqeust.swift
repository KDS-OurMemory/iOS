//
//  Reqeust.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import Foundation
import UIKit

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
    case body([String: Any])
    case url([String: Any])
    case formData([String: Any])
    case query([String: Any])
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: RequestParam { get }
    var format: String? { get }
    var formDataFormat: String? { get }
    var headers: [String]? { get }
}

extension Request {
    var method: HTTPMethod { return .get }
    var format: String? { return "application/json" }
    var formDataFormat: String? { return "multipart/form-data; boundaryBoundary-\(UUID().uuidString)" }
    var headers: [String]? { return ["content-Type", "accept"] }
    var images:[ImageFile]? { return nil}
    
    func urlRequest() -> URLRequest? {
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        
        // method
        request.httpMethod = method.name
        // header
        switch params {
        case.body( _),.url( _),.query( _):
            headers?.forEach { headerField in
                request.setValue(format, forHTTPHeaderField: headerField)
            }
            break
        case.formData( _):
            request.setValue(format, forHTTPHeaderField: (headers?.first)!)
            break
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
            let queryParams = params.map {
                URLQueryItem(name: $0.key, value: $0.value as? String)
                
            }
            var components = URLComponents(string: path)
            components?.queryItems = queryParams
            print("request \(params) in url =================>  \(path)")
            request.url = components?.url
        case .formData(let params):
            
            var body = Data()
            let boundaryPrefix = "--Boundary\(UUID().uuidString)\r\n"
            
            for (key, value) in params {
                body.append(contentsOf: boundaryPrefix.data(using: .utf8)!)
                body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\"\r\n\r\n".data(using: .utf8)!)
                body.append(contentsOf: "\(value)\r\n".data(using: .utf8)!)
            }
            
            if let images = images {
                for image in images {
                    body.append(contentsOf: boundaryPrefix.data(using: .utf8)!)
                    body.append(contentsOf: "Content-Disposition: form-data; name=\(image.key)\";  filename=\"\(image.fileName)\"\r\n".data(using: .utf8)!)
                    body.append(contentsOf: "Content-Type: image/\(image.type)\r\n\r\n".data(using: .utf8)!)
                    body.append(contentsOf: image.data)
                    body.append(contentsOf: "\r\n".data(using: .utf8)!)
                }
            }
                
            body.append(contentsOf: boundaryPrefix.data(using: .utf8)!)
            
            print("request \(params) in body =================>  \(path)")
            request.httpBody = body
        case .query(let params):
            let queryParams = params.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
                
            }
            var components = URLComponents(string: path)
            components?.queryItems = queryParams
            print("request \(params) in url =================>  " + (components?.url!.description ?? ""))
            request.url = components?.url
        }
        return request
    }
}
