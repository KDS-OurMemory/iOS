//
//  OurMemoryContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/20.
//

import Foundation
import UIKit

public protocol OurMemoryContract:BaseCollectionAdapterContract {
    func actionSearchBtn(sender:UIButton)
    func actionAddRoomBtn(sender:UIButton)
    func actionSettingsBtn(sender:UIButton)
    func reloadView()
    

}
