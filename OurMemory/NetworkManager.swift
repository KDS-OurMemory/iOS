//
//  NetworkManager.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/07.
//

import Foundation

class NetworkManager {
    
    static let session = URLSession.shared
    
    static func requestWeatherList(test:(String), completion: @escaping () -> Void) {
        
        let url = URL(string:" http://13.125.232.48:8080/OurMemory/SignUp/" + test)!
        
        let taskWithURL = session.dataTask(with: url) { (data, response, error) in
            let successRange = 200..<300
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                return
            }
            
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
        
            } catch {
                print("---> err: \(error.localizedDescription)")
            }
        }

        taskWithURL.resume()
    }
}
