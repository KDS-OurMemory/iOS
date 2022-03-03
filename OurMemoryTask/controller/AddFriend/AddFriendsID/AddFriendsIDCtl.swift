//
//  AddFriendsIDCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/22.
//

import UIKit

class AddFriendsIDCtl: BaseCollectionCtl {

    let addFriendsModel:AddFriendsIDModel = AddFriendsIDModel()
    
    override func __initWithData__(data: Any?) {
        self.addFriendsModel.initWithAddfriendsIdBlock { p1, p2 in
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

extension AddFriendsIDCtl: AddFriendsIDContract {
    
    func activeIDTab() {
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
                self.addFriendsModel.tryRequestAddFriendsSearchId(context: self, searchID: p1)
            }
            setAdapter.setOnOffBtnBlock { p1, p2 in
                switch p2.section {
                case 1:
                    self.addFriendsModel.tryAcceptRequestFriends(context: self, acceptIdx: p2.row)
                    break
                case 2:
                    (p1 ?
                     self.addFriendsModel.tryRequestFriends(context: self, searchIdx: p2.row):
                        self.addFriendsModel.tryCancelRequestFriends(context: self, searchIdx: p2.row))
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
