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
        if self.isActive {
            self.roomsModel.initWithCallback(data: data) { p1, p2 in
                switch p1 {
                case .ROOMSLIST_UPDATE:
                    if let adapter = self.adapter {
                        adapter.setData(section: 1, data: (p2 as! [roomData]) )
                    }
                    break
                case .ROOMSLIST_CHANGE:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: (p2 as! [roomData]))
                    }
                    break
                case .ROOMSSLIST_NODATA:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: p2 as! [Any])
                    }
                    break
                case .ROOMSLIST_APPENDITEM:
                    break
                }
            }
        }
    }
}


extension OurMemoryRoomsTabCtl: OurMemoryRoomsTabContract {
    func updateSearchView() {
        if let setAdapter = self.adapter,self.isActive {
            self.searchState = !self.searchState
            setAdapter.changeSearchItemState(state: searchState)
        }
    }
    
    func switchFriendTab() {
        self.isActive = false
    }
    
    func activeRoomsTab() {
        self.isActive = true
        self.roomsModel.tryRequestRoomsList(context: self)
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
