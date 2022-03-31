
//
//  viewContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/04/17.
//

import Foundation
import UIKit

public protocol ViewContract:AlertContract {
    func prepareViewWithData(data:Any?)
    func showNextVC(vc:NEXTVIEW,data:Any?);
}

public protocol AlertContract {
    func showNetworkErrorAlert()
    func showAlertMsgWithTitle(title:String,msg:String)
    func showAlertMsgWithTitleAndActions(title:String,msg:String, actions: [String:(UIAlertAction) -> Void])
    func showFadeOutMsgView(msg:String)
    func showActionSheetWithTitleAndActions(title:String,msg:String, actions:[String:(UIAlertAction) -> Void])
}

public protocol TabbarContract:ViewContract {
    func setTabbarView(tabView:UIView)
    func updateNotiCnt(items:[UInt:Int])
}

public protocol PopupContract:ViewContract {
    func dismissPopup()
}

