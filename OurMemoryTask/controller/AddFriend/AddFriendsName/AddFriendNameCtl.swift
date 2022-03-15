//
//  AddFriendNameCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class AddFriendNameCtl: BaseCollectionCtl {

    let addFriendsNameModel:AddFriendsNameModel = AddFriendsNameModel()
    
    override func __initWithData__(data: Any?) {
        self.addFriendsNameModel.initWithblock { p1, p2 in
            if self.isActive {
                
                switch p1 {
                case .UPDATEFINDDATA:
                    if let adapter = self.adapter {
                        adapter.setData(section: 2, data: (p2 as! [friendsData]) )
                    }
                    break
                case .UPDATEGETTINGFRIENDREQUEST:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: p2 as! [friendsData])
                    }
                    break
                case .NODATA:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: p2 as! [Any])
                    }
                    break
                case .APPENDDATA:
                    break
                case .CHANGEFINDDATA:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 2, data: p2 as! [friendsData])
                    }
                    break
                case .CHANGEGETTINGFRIENDREQUEST:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: p2 as! [friendsData])
                    }
                    break
                case .ACCEPTFRIEND:
                    if let adapter = self.adapter {
                        adapter.changeData(section: 1, data: p2 as! [friendsData])
                    }
                    break
                }
            }
        }
    }
    
    
    
}

extension AddFriendNameCtl:AddFriendNameContract {
    
    func activeNameTab() {
        self.isActive = true
        if let adapter = self.adapter {
            adapter.reloadCollectionView()
        }
    }
    
    
    func setCollectionWithAdpater(adapter: BaseCollectionAdapter) {
        self.adapter = adapter
        if let setAdapter = self.adapter {
            setAdapter.changeSearchItemState(state: true)
            setAdapter.setSearchBlock { p1 in
                self.addFriendsNameModel.tryRequestAddFriendsSearchName(context: self, searchName: p1)
            }
            
            setAdapter.setScrollBlock { p1, p2 in
                switch p2 {
                case .SCROLL_DID_SCROLLING:
                    break
                case .SCROLL_END_DECELERATING:
                    break
                }
            }
            
            setAdapter.setOnOffBtnBlock { p1, p2 in
                
                switch p2.section {
                case 1:
                    self.addFriendsNameModel.tryAcceptRequestFriends(context: self, acceptIdx: p2.row)
                    break
                case 2:
                    (p1 ?
                     self.addFriendsNameModel.tryRequestFriends(context: self, searchIdx: p2.row):
                        self.addFriendsNameModel.tryCancelRequestFriends(context: self, searchIdx: p2.row))
                    break
                default:
                    break
                }
            }
        }
    }
    
    func switchTab() {
        self.isActive = false
    }
    
}
