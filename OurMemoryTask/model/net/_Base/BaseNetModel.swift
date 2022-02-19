//
//  BaseNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import Foundation
import UIKit

class BaseNetModel {
    
    let session = URLSession.shared
    public var requestParams:RequestParam?
    var requestDic:[String:Any] = [:]
    var response:Codable?
    let errorData:OurMemoryErrorData = OurMemoryErrorData()
    var path:NETPATH!
    var images:[ImageFile]?
    var apendedPath:String = ""
    
    init() {
        if let dic = self.getRequestParamsKeys() {
            requestDic = dic
        }
    }
    
    struct dataRequest : Request {
        let standardURL = "https://ourmemory.ddns.net:8443"
        let session = URLSession.shared
        var path: String
        var method: HTTPMethod
        var params: RequestParam
        var images:[ImageFile]?
        
        init(method:HTTPMethod,path: String, param: RequestParam, images:[ImageFile]?) {
            self.method = method
            self.path = self.standardURL + path
            self.params = param
            self.images = images
        }
    }
    
    func addPath(path:String) {
        apendedPath = apendedPath + path
    }
    
    func getRequestParamsKeys() -> [String:Any?]? {
        return nil
    }
    
    func getPath() -> String {
        return ""
    }
    
    func getAddPath() -> String {
        return self.apendedPath
    }
    
    func setImage(images:[ImageFile]) {
        self.images = images
    }
    
    func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.get
    }
    
    func setRequestBodyParams(params:[String:Any]) {
        self.requestParams = .body(params)
    }
    
    func setRequestUrlParams(params:[String:Any]) {
        
        self.requestParams = .url(params)
    }
    
    func setRequestFormDataParams(params:[String:Any]) {
        self.requestParams = .formData(params)
    }
    
    func setRequestQueryParams(params:[String:Any]) {
        self.requestParams = .query(params)
    }
    
    func reqeustRestFulApi <T: Codable>(context:DataContract ,completion: @escaping (Result<T, Error>) -> Void) {
        guard let params = self.requestParams else {return}
        
        guard let url = dataRequest(method: getHttpMethod(), path: getPath() + getAddPath(), param: params, images: self.images).urlRequest()?.url else { return }
        guard let request = dataRequest(method: getHttpMethod(), path: getPath() + getAddPath(), param: params, images: self.images).urlRequest() else {return}
        
        switch getHttpMethod() {
        case .get:
            session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let responseData = data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let responseWithDecoder = try decoder.decode(T.self, from: responseData)
                    
                    self.response = responseWithDecoder
                    if let returnReseponse = self.response {
                        print("response by : { \n \(returnReseponse) \n }")
                        
                        let resultCode:String = try returnReseponse.asDictionary()["resultCode"] as! String
                        let resultMessage:String = try returnReseponse.asDictionary()["resultMessage"] as! String
                        if resultCode != NETRESULTCODE.SUCCESS {
                            self.errorData.errorCode = resultCode;
                            self.errorData.msg = resultMessage
                            context.onTaskError(ourMemoryErr: self.errorData)
                        }
                        
                    }
                    completion(.success(responseWithDecoder))
                    
                } catch {
                    guard let error = error as? DecodingError else {return}
                    
                    switch error {
                    case .typeMismatch(let type, let decodingError):
                        print("Type '\(type)' mismatch:", decodingError.debugDescription)
                        break
                    case .valueNotFound(let value, let decodingError):
                        print("Value '\(value)' not found:", decodingError.debugDescription)
                        print("codingPath:", decodingError.codingPath)
                        break
                    case .keyNotFound(let codingKey, let decodingError):
                        print("Key '\(codingKey) not found:", decodingError.debugDescription)
                        print("codingPath:", decodingError.codingPath)
                        break
                    case .dataCorrupted(let decodingError):
                        print(decodingError)
                        break
                    default:
                        print("error:",error)
                        break
                    }
                    
                    completion(.failure(error))
                    self.errorData.errorCode = "-";
                    context.onTaskError(ourMemoryErr: self.errorData)
                }
            }.resume()
            break
        case .post:
            session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let responseData = data else { return }
                let decoder = JSONDecoder()
                do {
                    let returnReseponse = try decoder.decode(T.self, from: responseData)
                    print("response by : \(T.self) { \n \(returnReseponse) \n }")
                    let resultCode:String = try returnReseponse.asDictionary()["resultCode"] as! String
                    let resultMessage:String = try returnReseponse.asDictionary()["resultMessage"] as! String
                    if resultCode != NETRESULTCODE.SUCCESS {
                        self.errorData.errorCode = resultCode;
                        self.errorData.msg = resultMessage
                        context.onTaskError(ourMemoryErr: self.errorData)
                    }
                    completion(.success(returnReseponse))
                } catch {
                    guard let error = error as? DecodingError else {return}
                    
                    switch error {
                    case .typeMismatch(let type, let decodingError):
                        print("Type '\(type)' mismatch:", decodingError.debugDescription)
                        break
                    case .valueNotFound(let value, let decodingError):
                        print("Value '\(value)' not found:", decodingError.debugDescription)
                        print("codingPath:", decodingError.codingPath)
                        break
                    case .keyNotFound(let codingKey, let decodingError):
                        print("Key '\(codingKey) not found:", decodingError.debugDescription)
                        print("codingPath:", decodingError.codingPath)
                        break
                    case .dataCorrupted(let decodingError):
                        print(decodingError)
                        break
                    default:
                        print("error:",error)
                        break
                    }
                    
                    completion(.failure(error))
                    self.errorData.errorCode = "-";
                    context.onTaskError(ourMemoryErr: self.errorData)
                }
            }.resume()
            break
        default:
            break
        }
        
        
    }
    
   
}
