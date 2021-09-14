//
//  MainViewCollectionView.swift
//  OurMemory
//
//  Created by 이승기 on 2021/05/16.
//

import UIKit

class weekCollectionCtl: BaseCollectionCtl {
//    var mainVC:MainViewController = MainViewController()
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.description(), for: indexPath)
        
        return cell
    }
}
