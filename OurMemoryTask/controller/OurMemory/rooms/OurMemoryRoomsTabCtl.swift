//
//  OurMemoryRoomsTabCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/20.
//

import UIKit

class OurMemoryRoomsTabCtl: BaseCollectionCtl {
    
    let roomsModel:RoomsModel = RoomsModel()
    var searchState:Bool = false
    
    override func __initWithData__(data: Any?) {
        
            
    }
}


extension OurMemoryRoomsTabCtl: OurMemoryRoomsTabContract {
    func updateSearchView() {
        if let setAdapter = self.adapter,self.isActive {
            self.searchState = !self.searchState
            setAdapter.changeSearchItemState(state: searchState)
        }
    }
    
    func setCollectionWithAdpater( adapter: BaseCollectionAdapter) {
        self.adapter = adapter
        if let setAdapter = self.adapter {
            setAdapter.changeSearchItemState(state: false)
            setAdapter.setSearchBlock { p1 in
                
            }
            setAdapter.setCellBlock { p1 in
                switch p1.section {
                case 0:
                    break
                case 1:
                    self.callShowNextVC(view: .NEXTVIEW_ROOMDETAIL, data: self.roomsModel.getSelectDataIdx(index: p1.row))
                    break
                default:
                    break
                }
            }
        }
    }
 
}
