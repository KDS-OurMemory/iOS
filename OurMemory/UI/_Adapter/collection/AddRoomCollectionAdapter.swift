//
//  AddRoomCollectionAdapter.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class AddRoomCollectionAdapter: BaseCollectionAdapter {

    override func getSectionCnt() -> Int {
        return (self.hasData() ? 2:1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let noItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: NoItemCollectionViewCell.className(), for: indexPath) as? NoItemCollectionViewCell
        switch indexPath.section {
        case FRIENDSCOLLECTION_SECTION.FRIENDSSEARCH_SECTION.rawValue:
            
            if let searchCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.className(), for: indexPath) as? SearchCollectionViewCell {
                    searchCell.setPlaceholder(placeholder: "이름 검색")
                    searchCell.changeOpenSearchCell(state: self.isSearchItem)
                    searchCell.setSearchBlock { p1 in
                        if let searchBlock = self.searchBlock {
                            searchBlock(p1)
                        }
                    }
                    
                    
                return searchCell
            }
                
            
            break
        case FRIENDSCOLLECTION_SECTION.FRIENDSLIST_SECTION.rawValue:
            if let data = self.getIndexPathDataAt(indexPath: indexPath) as? FriendsDataBinder {
                if let friendCell = collectionView.dequeueReusableCell(withReuseIdentifier: CheckFriendsCollectionViewCell.className(), for: indexPath) as? CheckFriendsCollectionViewCell {
                    friendCell.setData(data: data)
                    
                    friendCell.setTryCheckFriendsBtnBlock { p1 in
                        if let block = self.onOffBtnBlock {
                            block(p1,indexPath)
                        }
                    }
                    
                    return friendCell
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
            case FRIENDSCOLLECTION_SECTION.FRIENDSSEARCH_SECTION.rawValue:
                let searchViewSize = CGSize(width: collectionView.frame.width, height: (self.isSearchItem ? 50.0:1))
                return searchViewSize
            case FRIENDSCOLLECTION_SECTION.FRIENDSLIST_SECTION.rawValue:
                let friendListSize = CGSize(width: collectionView.frame.width, height:self.getFriendsListItemHeight(collectionView: collectionView))
                
                return friendListSize
            default:
                break
            }
        }
        
        return collectionView.frame.size
    }
    
    
    func getFriendsListItemHeight(collectionView:UICollectionView) -> CGFloat {
        return (self.haseDataAtSection(section: 1) ?
         40.0:
            collectionView.frame.height - (self.isSearchItem ? 50.0:1))
    }
    
}