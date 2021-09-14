//
//  IntroModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import UIKit

class IntroModel: NSObject {

    let introNetModel = IntroNetModel()
    let autoLoginNetModel = AutoLoginNetModel()
    
    var userDataCallback:((INTRONETCASE)-> Void)!
    func initWithCallback(callback: @escaping (INTRONETCASE)-> Void ) {
        introNetModel.initWithCallback{ validCase  in
            
        }
        
        autoLoginNetModel.initWithCallback { validCase in
            switch validCase {
            case .KNOWN_CASE:
                break
            case .NOTCONNECTNET_CASE:
                break
            case .REQUESTERROR_CASE:
                self.userDataCallback(.REQUESTERROR_CASE)
                break
            case .SUCCESS_CASE:
                switch self.autoLoginNetModel.getResultCode() {
                case NETRESULTCODE.SUCCESS:
                    self.userDataCallback(.SUCCESS_CASE)
                    break
                case NETRESULTCODE.USERREQUEST_ERROR:
                    break
                case NETRESULTCODE.NOTFINDUSERDATA_ERROR:
                    break
                default:
                    break
                }
                break
            case .FAILE_CASE:
                self.userDataCallback(.FAILE_CASE)
                break
            }
        }
        
        self.userDataCallback = callback
    }
    
    func tryAutoLoginRequest() {
        self.autoLoginNetModel.tryAutoLoginRequest()
    }
    

}




    
    
    

