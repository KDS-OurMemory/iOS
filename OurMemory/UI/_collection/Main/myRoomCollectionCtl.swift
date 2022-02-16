//
//  myRoomCollectionCtl.swift
//  OurMemory
//
//  Created by 이승기 on 2021/06/06.
//

import UIKit
import OurMemoryTask

class myRoomCollectionCtl: BaseCollectionAdapter {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.description(), for: indexPath)
        
        return cell
    }
}
