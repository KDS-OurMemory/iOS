//
//  MyProfileModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/25.
//

import UIKit


enum MYPROFILE_RESULT {
    case UPDATEUSERDATA
    case UPDATEPROFILEIMG
}

class MyProfileModel: NSObject {
    
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    var myProfileBlock:((MYPROFILE_RESULT,Any?) -> Void)?
    var profileUserData:userData!
    let myProfileImgNetModel:UploadMyProfileImgNetModel = UploadMyProfileImgNetModel()
    let modifyPushTokenNetModel:ModifyPushTokenNetmodel = ModifyPushTokenNetmodel()
    var profileImage:UIImage?
    
    func initWithDataProfileBlock(data:Any?,block:@escaping (MYPROFILE_RESULT,Any?) -> Void) {
        myProfileBlock = block
        profileUserData = sharedUserDataModel.userData
        
        if let block = self.myProfileBlock {
            block(.UPDATEUSERDATA,self.profileUserData)
        }
    }
    
    func setIsSolar(isSolar:Bool) {
        self.profileUserData.solar = isSolar
    }
    
    func setBirthdayIsOpen(isOpen:Bool) {
        self.profileUserData.birthdayOpen = isOpen
    }
    
    func setPushState(state:Bool) {
        self.profileUserData.push = state
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width // 새 이미지 확대/축소 비율
        let newHeight = image.size.height * scale
        let size = CGSize(width:newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImg = render.image { context in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
        
        return renderImg
    }
    
    func tryUploadProfileImage(context:DataContract ,profileImage:UIImage) {
        
//        self.profileImage = self.resizeImage(image: profileImage, newWidth: 20)
        self.profileImage = profileImage
        
        self.myProfileImgNetModel.setRequestPathAndFormData(path: [
            "\(sharedUserDataModel.userData.userId)",
            "profileImage"
        ], formData: [
            "birthday":sharedUserDataModel.userData.birthday,
            "birthdayOpen":sharedUserDataModel.userData.birthdayOpen,
            "deviceOs":sharedUserDataModel.userData.deviceOs,
            "name":sharedUserDataModel.userData.name,
            "solar":sharedUserDataModel.userData.solar,
            "snsId":sharedUserDataModel.userData.snsId,
            "snsType":sharedUserDataModel.userData.snsType,
            "pushToken":sharedUserDataModel.userData.pushToken,
            "push":sharedUserDataModel.userData.push,
        ])
        
//        self.myProfileImgNetModel.setImage(images: [
//            ImageFile(fileName: "\(sharedUserDataModel.userData.userId)_profileImage", data: profileImage.pngData()!, type: "png", key: "profileImage"),
//        ])
        
        self.myProfileImgNetModel.reqeustRestFulApi(context: context) { (data: Result<json<userData>, Error>) in
            switch data {
            case .success(_):
                if let block = self.myProfileBlock {
                    block(.UPDATEPROFILEIMG,self.profileImage)
                }
                break
            default:
                break
            }
        }
        
    }
    
    func tryModifyPushToken(context:DataContract) {
        self.modifyPushTokenNetModel.reqeustRestFulApi(context: context) { (data:Result<json<userData>, Error>) in
            switch data {
            case .success(_):
                break
            default:
                break
            }
        }
    }
    
}
