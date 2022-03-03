//
//  MyMemoryCollectionAdapter.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/01.
//

import UIKit

class MyMemoryCollectionAdapter: BaseCollectionAdapter {

    let maxHeight = mainHeight - 80
    
    override func getSectionCnt() -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let calenderCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyMemoryCollectionViewCell.className(), for: indexPath) as? MyMemoryCollectionViewCell else { return UICollectionViewCell() }
        let data = self.getIndexPathDataAt(indexPath: indexPath) as! CalSelectDateDataBinder
        calenderCell.setData(data:data,opecity:(collectionView.frame.height>=self.orgCollectionSize!.height ? collectionView.frame.height/maxHeight - self.orgCollectionSize!.height/maxHeight:0))
        return calenderCell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/7, height: collectionView.frame.height/(self.getDataCntAtSection(section: indexPath.section) > 35 ? 6:5))
    }
    
    
    
}
