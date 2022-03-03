//
//  AddRoomCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import UIKit

class AddRoomCtl: BaseCollectionCtl {

    let addRoomModel:AddRoomModel = AddRoomModel()
    
    override func __initWithData__(data: Any?) {
        self.addRoomModel.initWithAddRoomModelBlock { p1, p2 in
            switch p1 {
            case .UPDATE:
                if let adapter = self.adapter {
                    adapter.setData(section: 1, data: (p2 as! [friendsData]) )
                }
                break
            case .CHANGE:
                if let adapter = self.adapter {
                    adapter.changeData(section: 1, data: p2 as! [friendsData])
                }
                break
            case .NODATA:
                if let adapter = self.adapter {
                    adapter.changeData(section: 1, data: p2 as! [Any])
                }
                break
            case .RELOADROW:
                if let adapter = self.adapter {
                    let data = p2 as! (Int, [friendsData])
                    adapter.setDataWithOutLoad(section: 1, data: data.1)
                    adapter.reloadCollectionViewAtRow(row: data.0, atSection: 1)
                }
                break
            case .APPENDITEM:
                break
            case .SELECT:
                let data = p2 as! [friendsData]
                self.callUpdateSelectedUserDatas(datas: data)
                self.callUpdateSelectedUserCnt(cnt: data.count)
                break
            case .DESELECT:
                let data = p2 as! [friendsData]
                self.callUpdateSelectedUserDatas(datas: data)
                self.callUpdateSelectedUserCnt(cnt: data.count)
                break
            case .MAKEROOM:
                self.callShowNextVC(view: .NEXTVIEW_POP, data: p2 as! roomData)
                break
            }
        }
    }
    
    fileprivate func callUpdateSelectedUserDatas(datas:[FriendsDataBinder]) {
        if let view = self.view as? AddRoomView {
            view.updateSelectedUserDatas(datas: datas)
        }
    }
    
    fileprivate func callUpdateSelectedUserCnt(cnt:Int) {
        if let view = self.view as? AddRoomView {
            view.updateSelectedUserCnt(cnt: cnt)
        }
    }
    
}

extension AddRoomCtl:AddRoomContract {
    
    func setCollectionWithAdpater(adapter: BaseCollectionAdapter) {
        self.adapter = adapter
        if let setAdapter = self.adapter {
            setAdapter.changeSearchItemState(state: true)
            setAdapter.setSearchBlock { p1 in
                self.addRoomModel.searchFriendsData(searchStr: p1)
            }
            setAdapter.setOnOffBtnBlock { p1, p2 in
                (p1 ?
                 self.addRoomModel.selectFriendAtIndex(index: p2.row):
                    self.addRoomModel.deSelectUserCollectionViewIndex(index: p2.row))
            }
            self.addRoomModel.tryRequestFriendsList(context: self)
        }
        
    }
    
    func removeSelectedUserItemAtIndex(idx:Int) {
        self.addRoomModel.deSelectedUserItemIndex(index: idx)
    }
    
    func actionConfirmBtn() {
        self.addRoomModel.tryRequestMakeRoom(context: self)
    }
}
