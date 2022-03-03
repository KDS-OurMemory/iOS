//
//  String+url.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/23.
//

import Foundation
import UIKit

extension String {
    func urlStringToImage(block:@escaping (UIImage?)->Void) {
        if let url = URL(string: self) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    block(UIImage(data: data!))
                }
            }
        }
    }
}


