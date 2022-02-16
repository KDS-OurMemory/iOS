//
//  baseCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/02/26.
//

import UIKit

class BaseCtl:NSObject {

    var view:ViewContract!
    var collection:BaseCollectionAdapter!

    init(view:ViewContract, data:Any?) {
        super.init()
        self.view = view
        self.__initWithData__(data: data )
    }
    
    func __initWithData__(data:Any?) {
        print("재정의 매소드")
    }
    
    func callShowNextVC(view:NEXTVIEW, data:Any?) {
        self.view.showNextVC(vc: view, data: data)
    }
    
    func onTaskError(ourMemoryErr: OurMemoryErrorData) {
        self.view.showAlertMsgWithTitle(title: "", msg: ourMemoryErr.errorCode)
    }
    
}

extension BaseCtl:DataContract {
    
}
