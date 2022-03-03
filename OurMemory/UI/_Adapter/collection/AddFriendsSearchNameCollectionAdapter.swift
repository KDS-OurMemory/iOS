//
//  AddFriendsSearchNameCollectionAdapter.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class AddFriendsSearchNameCollectionAdapter: BaseCollectionAdapter {

    override func getSectionCnt() -> Int {
        return (self.hasData() ? 3:1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let noItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: NoItemCollectionViewCell.className(), for: indexPath) as? NoItemCollectionViewCell
        switch indexPath.section {
        case ADDFRIENDSCOLLECTION_SECTION.ADDFRIENDSSEARCH_SECTION.rawValue:
            if self.isSearchItem {
                if let searchCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.className(), for: indexPath) as? SearchCollectionViewCell {
                    searchCell.setPlaceholder(placeholder: "사용자 이름으로 검색")
                    searchCell.setSearchBlock { p1 in
                        if let searchBlock = self.searchBlock {
                            searchBlock(p1)
                        }
                    }
                    
                    return searchCell
                }
                
            }
            break
        case ADDFRIENDSCOLLECTION_SECTION.ACCEPTADDFRIENDS_SECTION.rawValue:
            if let data = self.getIndexPathDataAt(indexPath: indexPath) as? FriendsDataBinder {
                if let searchAtIDFriendCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddFriendsCollectionCell.className(), for: indexPath) as? AddFriendsCollectionCell {
                    searchAtIDFriendCell.setData(data: data)
                    searchAtIDFriendCell.setTryAddFriendsBtnBlock { p1 in
                        if let onOffBlock = self.onOffBtnBlock {
                            onOffBlock(p1,indexPath)
                        }
                    }
                    return searchAtIDFriendCell
                }
                
            }
            break
        case ADDFRIENDSCOLLECTION_SECTION.ADDFRIENDSLIST_SECTION.rawValue:
            if let data = self.getIndexPathDataAt(indexPath: indexPath) as? FriendsDataBinder {
                if let searchAtIDFriendCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddFriendsCollectionCell.className(), for: indexPath) as? AddFriendsCollectionCell {
                    searchAtIDFriendCell.setData(data: data)
                    searchAtIDFriendCell.setTryAddFriendsBtnBlock { p1 in
                        if let onOffBlock = self.onOffBtnBlock {
                            onOffBlock(p1,indexPath)
                        }
                    }
                    return searchAtIDFriendCell
                }
                
            }
            break
        default:
            break
        }
        return noItemCell!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.hasData() {
            switch indexPath.section {
            case ADDFRIENDSCOLLECTION_SECTION.ADDFRIENDSSEARCH_SECTION.rawValue:
                let searchViewSize = CGSize(width: collectionView.frame.width, height: (self.isSearchItem ? 50.0:0))
                return searchViewSize
            case ADDFRIENDSCOLLECTION_SECTION.ACCEPTADDFRIENDS_SECTION.rawValue,ADDFRIENDSCOLLECTION_SECTION.ADDFRIENDSLIST_SECTION.rawValue:
                let friendListSize = CGSize(width: collectionView.frame.width, height: self.getFriendsListItemHeight(collectionView: collectionView))
                return friendListSize
            default:
                break
            }
        }
        
        return collectionView.frame.size
    }
    
    func getFriendsListItemHeight(collectionView:UICollectionView) -> CGFloat {
        return ( (self.haseDataAtSection(section: 1)&&self.haseDataAtSection(section: 2)) ?
         40.0:
            collectionView.frame.height - (self.isSearchItem ? 50.0:1))
    }
    
}
