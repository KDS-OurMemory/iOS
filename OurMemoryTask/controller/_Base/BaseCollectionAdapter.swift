//
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/20.
//

import Foundation
import UIKit

open class BaseCollectionAdapter:NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collectionView:UICollectionView?
    var datas:[String:Any]?
    
    func setCollection(collectionView:UICollectionView) {
        self.collectionView = collectionView
        if let col = self.collectionView {
            col.delegate = self
            col.dataSource = self
        }
    }
    
    func setData(data:Codable) {
        guard let data = try? data.asDictionary() else {
            return
        }
        self.datas = data
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = self.datas {
            let cnt = data.count
            return cnt
        }
        return 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        return cell
    }
    
    
}


