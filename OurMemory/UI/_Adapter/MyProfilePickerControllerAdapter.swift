//
//  ViewImagePickerControllerAdapter.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/28.
//

import UIKit
import PhotosUI

class MyProfilePickerControllerAdapter: BasePHPickerControllerAdapter {

    
    override func getSelectionLimit() -> Int {
        return 1
    }
    
    override func getPickerFilter() -> PHPickerFilter {
        return PHPickerFilter.any(of: [.images])
    }
}
