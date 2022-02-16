//
//  LoginView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import Foundation

public protocol LoginView:ViewContract {
    
    func openUrlForSnsLogin(url:URL) -> Bool
}
