//
//  MyProfileCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class MyProfileCtl: BaseCtl {

    var imgPickerAdapter:BasePHPickerControllerAdapter?
    let myProfileModel:MyProfileModel = MyProfileModel()
    
    override func __initWithData__(data: Any?) {
        self.myProfileModel.initWithDataProfileBlock(data: data) { p1, p2 in
            switch p1 {
            case .UPDATEUSERDATA:
                self.callUpdateProfileData(profileData: p2 as! userData)
                break
            case .UPDATEPROFILEIMG:
                self.callUpdateProfileImage(profileimage: p2 as! UIImage)
                break
            default:
                break
            }
        }
    }
    
    fileprivate func callUpdateProfileImage(profileimage:UIImage) {
        if let view = self.view as? MyProfileView {
            view.updateProfileImage(profileImg: profileimage)
        }
    }
    
    fileprivate func callUpdateProfileData(profileData:UserDataBinder) {
        if let view = self.view as? MyProfileView {
            view.updateProfileData(profileData: profileData)
        }
    }
    
    
}

extension MyProfileCtl: MyProfileContract {
    
    func setPHPickerControllerAdapter(adapter: BasePHPickerControllerAdapter) {
        self.imgPickerAdapter = adapter
        if let setAdapter = self.imgPickerAdapter {
            setAdapter.setPickerBlock { p1, p2 in
                switch p1 {
                case .SELECT_IMAGE:
                    self.myProfileModel.tryUploadProfileImage(context: self, profileImage: p2 as! UIImage)
                    break
                default:
                    break
                }
            }
        }
        
    }
    
    func actionProfileImage(imageSize:CGSize) {
        if let setAdapter = self.imgPickerAdapter {
            setAdapter.showPickerView()
        }
    }
    
    
    func actionSwitchPush(state: Bool) {
        
    }
    
    func actionLogoutBtn() {
        
    }
    
    
}
