//
//  mainCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/02/26.
//

import UIKit

class mainCtl: BaseCtl {

    let mainModel:MainModel = MainModel()
    override func __initWithData__(data: Any?) {
        self.mainModel.initWithCallback { vaildeCase in
            switch vaildeCase {
            case .UPDATE_ROOMLIST:
                self.callUpdateRoomList()
                break
            default:
            break
            }
        }
    }
    
    func callUpdateRoomList() {
//        if let data = self.mainModel.getMyRoomListData() {
//            self.collection.setData(data: data)
//        }
    }
    
    func callUpdateCollectionViewReload() {
        if let view = self.view as? MainView {
            view.reloadCollectionView()
        }
    }
}

extension mainCtl: MainContract {
    
    func setCollectionWithAdpater(collection: UICollectionView, Adapter: BaseCollectionAdapter) {
        self.collection = Adapter
        self.collection.collectionView = collection
    }
    
    func tryGetMyRommListRequest() {
        self.mainModel.tryGetMyRommList()
    }
}
