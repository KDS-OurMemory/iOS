//
//  IntroModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import UIKit

class IntroModel: NSObject {

    let introNetModel = IntroNetModel()
    let loginNetModel = LoginNetModel()
    
    var userDataCallback:((INTRONETCASE)-> Void)!
    func initWithCallback(callback: @escaping (INTRONETCASE)-> Void ) {
        
        self.userDataCallback = callback
        self.userDataCallback(.SUCCESS_CASE)
    }
    
    
}






    
    
    

