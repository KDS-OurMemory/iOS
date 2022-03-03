//
//  OurMemoryCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class OurMemoryFriendsTabCtl: BaseCollectionCtl {

    let friendsModel:FriendsModel = FriendsModel()
    var searchState:Bool = false
    
    override func __initWithData__(data: Any?) {
        if self.isActive {
            self.friendsModel.initWithCallback(data: data) { p1, p2 in
                switch p1 {
                case .FRIENDSLIST_UPDATE:
                    if let adapter = self.adapter {
                        adapter.setData(section: 1, data: (p2 as! [friendsData]) )
                    }
                    break
                case .FRIENDSLIST_CHANGE:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: (p2 as! [friendsData]))
                    }
                    break
                case .FRIENDSLIST_NODATA:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: p2 as! [Any])
                    }
                    break
                case .FRIENDSLIST_APPENDITEM:
                    break
                
                }
            }
        }
    }
    
}


extension OurMemoryFriendsTabCtl: OurMemoryFriendsTabContract {
    
    func updateSearchView() {
        if let setAdapter = self.adapter,self.isActive {
            self.searchState = !self.searchState
            setAdapter.changeSearchItemState(state: self.searchState)
        }
    }
    
    
    func switchRoomsTab() {
        self.isActive = false
    }
    
    func activeFriendsTab() {
        self.isActive = true
        self.friendsModel.tryRequestFriendsList(context: self)
    }
    
    func setCollectionWithAdpater(adapter: BaseCollectionAdapter) {
        self.adapter = adapter
        if let setAdapter = self.adapter {
            setAdapter.changeSearchItemState(state: false)
            setAdapter.setSearchBlock { p1 in
                self.friendsModel.searchFriendsData(searchStr: p1)
            }
            
        }
    }
    
    
}