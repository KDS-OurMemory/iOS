//
//  BaseImageControllerAdapter.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/28.
//

import UIKit
import PhotosUI

enum PHPICKER_RESULT {
    case SELECT_IMAGE
    case SELECT_IMAGES
}

open class BasePHPickerControllerAdapter: NSObject,PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    var fetchResult: PHFetchResult<PHAsset>?
    var canAccessImages: [UIImage] = []
    var imgPickerController:UIImagePickerController?
    var context:UIViewController?
    var configuration:PHPickerConfiguration = PHPickerConfiguration()
    var picker:PHPickerViewController?
    var pickerBlock:((PHPICKER_RESULT,Any?) -> Void)?
    var selectImageArr:[UIImage] = []
    
    public override init() {
        super.init()
        self.configuration.selectionLimit = self.getSelectionLimit()
        self.configuration.filter = self.getPickerFilter()
        self.picker = PHPickerViewController(configuration: configuration)
        self.picker?.delegate = self
    }
    
    public func setContext(context:UIViewController) {
        self.context = context
    }
    
    public func showPickerView() {
        if let picker = self.picker {
            self.context?.present(picker, animated: true, completion: nil)
        }
        
    }
    
    func setPickerBlock(block:@escaping (PHPICKER_RESULT,Any?) -> Void) {
        self.pickerBlock = block
    }
    
    open func getSelectionLimit() -> Int {
        return 0
    }
    
    open func getPickerFilter() -> PHPickerFilter {
        return PHPickerFilter.any(of: [.images,.videos])
    }
    
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        self.selectImageArr.removeAll()
        picker.dismiss(animated: true, completion: nil)
        
        for result in results {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        if let block = self.pickerBlock,results.count == 1 {
                            block(.SELECT_IMAGE,image as? UIImage)
                        }
                    }
                    self.selectImageArr.append(image as! UIImage)
                }
            } else {
                // TODO: Handle empty results or item provider not being able load UIImage
            }
        }
        if let block = self.pickerBlock,results.count > 1 {
            block(.SELECT_IMAGES,self.selectImageArr)
        }
    }
    
    func cameraAuth() -> Bool {
           return AVCaptureDevice.authorizationStatus(for: .video) == AVAuthorizationStatus.authorized
       }


       func authSettingOpen(AuthString: String) {
           if let AppName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
               let message = "\(AppName)이(가) \(AuthString) 접근 허용되어 있지않습니다. \r\n 설정화면으로 가시겠습니까?"
               let alert = UIAlertController(title: "설정", message: message, preferredStyle: .alert)

               let cancle = UIAlertAction(title: "취소", style: .default) { (UIAlertAction) in
                   print("\(String(describing: UIAlertAction.title)) 클릭")
               }
               
               let confirm = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
                   UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
               }
               
               alert.addAction(cancle)
               alert.addAction(confirm)
               
               if let context = self.context {
                   context.present(alert, animated: true, completion: nil)
               }
           }
           
       }
    
}
