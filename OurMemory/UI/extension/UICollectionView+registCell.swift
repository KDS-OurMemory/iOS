//
//  UICollectionView+registCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/22.
//

import Foundation
import UIKit

extension UICollectionView {
    func registCell(cellIdentifier:String) {
        self.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
}
