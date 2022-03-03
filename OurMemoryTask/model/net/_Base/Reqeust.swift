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
    case pathFormData([String],[String:Any])
    case query([String: Any])
    case path([String])
    case pathQuery([String],[String:Any])
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: RequestParam { get }
    var format: String? { get }
    var formDataFormat: String? { get }
    var headers: [String]? { get }
    var images:[ImageFile]? { get }
}

extension Request {
    var method: HTTPMethod { return .get }
    var format: String? { return "application/json" }
    var formDataFormat: String? { return "multipart/form-data; boundary=--Boundary-\(UUID().uuidString)" }
    var headers: [String]? { return ["Content-Type", "accept"] }
    
    func urlRequest() -> URLRequest? {
        var url:URL!
        
        switch params {
        case .pathQuery(let addPath, _),.pathFormData(let addPath, _):
            url = URL(string: path + "/" + addPath.joined(separator: "/") + "?" )!
            break
        case .path(let addPath):
//            print(path + "" + addPath.joined(separator: "\""))
            url = URL(string: path + "/" + addPath.joined(separator: "/") )!
            break
        case .query(_):
            url = URL(string: path+"?")!
            break
        default:
            url = URL(string: path)!
            break
        }
        
        var request = URLRequest(url: url)
        // method
        request.httpMethod = method.name
        // header
        switch params {
        case.body( _),.url( _),.query( _),.path( _),.pathQuery(_, _):
            headers?.forEach { headerField in
                request.setValue(format, forHTTPHeaderField: headerField)
            }
            break
        case.formData( _),.pathFormData(_, _):
            request.setValue(formDataFormat, forHTTPHeaderField: (headers?.first)!)
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
            let boundaryPrefix = "Boundary-\(UUID().uuidString)\r\n"
            
            for (key, value) in params {
                body.append(contentsOf: "--\(boundaryPrefix)".data(using: .utf8)!)
                body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\"\r\n\r\n".data(using: .utf8)!)
                body.append(contentsOf: "\(value)\r\n".data(using: .utf8)!)
            }
            
            if let images = images {
                for image in images {
                    body.append(contentsOf: "--\(boundaryPrefix)".data(using: .utf8)!)
                    body.append(contentsOf: "Content-Disposition: form-data; name=\(image.key)\";  filename=\"\(image.fileName)\"\r\n".data(using: .utf8)!)
                    body.append(contentsOf: "Content-Type: image/\(image.type)\r\n\r\n".data(using: .utf8)!)
                    body.append(contentsOf: image.data)
                    body.append(contentsOf: "\r\n".data(using: .utf8)!)
                }
            }
                
            body.append(contentsOf: "--\(boundaryPrefix)--\r\n".data(using: .utf8)!)
            
            print("request \(params) in formData =================>  \(path)")
            request.httpBody = body
        case .query(let querys):
            let queryParams = querys.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
                
            }
            var components = URLComponents(string: path)
            components?.queryItems = queryParams
            print("request \(params) in url =================>  " + (components?.url!.description ?? ""))
            request.url = components?.url
        case .path(let addPath):
            print("request \(addPath) in Path ==============> " + path)
        case .pathQuery(let addPath, let querys):
            let queryParams = querys.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
                
            }
            var components = URLComponents(string: path + "/" + addPath.joined(separator: "/") + "?" )
            components?.queryItems = queryParams
            print("request \(params) in path,query =================>  " + (components?.url!.description ?? ""))
            request.url = components?.url
        case .pathFormData(let addPath, let params):
            
            let components = URLComponents(string: path + "/" + addPath.joined(separator: "/") + "?" )
            
            print("request \(params) in path,formData =================>  " + (components?.url!.description ?? ""))
            request.url = components?.url
            var body = Data()
            let boundaryPrefix = "Boundary-\(UUID().uuidString)\r\n"
            
            for (key, val) in params {
                body.append(contentsOf: "--\(boundaryPrefix)\r\n".data(using: .utf8)!)
                body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append(contentsOf: "\(val)\r\n".data(using: .utf8)!)
            }
            
            if let images = self.images {
                for image in images {
                    body.append(contentsOf: "--\(boundaryPrefix)\r\n".data(using: .utf8)!)
                    body.append(contentsOf: "Content-Disposition: form-data; name=\"\(image.key)\";  filename=\"\(image.fileName)\"\r\n".data(using: .utf8)!)
                    body.append(contentsOf: "Content-Type: image/\(image.type)\r\n\r\n".data(using: .utf8)!)
                    body.append(contentsOf: image.data)
                    body.append(contentsOf: "\r\n".data(using: .utf8)!)
                    
                }
            }
            
            body.append(contentsOf: "--\(boundaryPrefix)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
        }
    
        return request
    }
}
