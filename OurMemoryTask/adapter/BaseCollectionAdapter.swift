//
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/20.
//

import Foundation
import UIKit

open class BaseCollectionAdapter:NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    public enum scrollState {
        case SCROLL_END_DECELERATING
        case SCROLL_DID_SCROLLING
    }
    
    public var collectionView:UICollectionView?
    var datas:[Int:[Any]?] = [:]
    public var isSearchItem:Bool = false
    public var searchBlock:((String) -> Void)?
    public var onOffBtnBlock:((Bool,IndexPath) -> Void)?
    public var orgCollectionSize:CGSize?
    public var scrollBlock:((UIScrollView,scrollState) -> Void)?
    public var cellClickBlock:((IndexPath)->Void)?
    
    public func setCollection(collectionView:UICollectionView) {
        
        self.collectionView = collectionView
        if let col = self.collectionView {
            col.delegate = self
            col.dataSource = self
            self.orgCollectionSize = col.frame.size
        }
        
    }
    
    open func getSectionCnt() -> Int {
        return 0
    }
    
    public func getDataCntAtSection(section:Int) -> Int {
        if let data = self.datas[section] {
            return data!.count
        }
        return 0
    }
    
    func changeSearchItemState(state:Bool) {
        isSearchItem = state
        if state {
            self.datas[0] = ["search"]
        }
        self.reloadCollectionView()
    }
    
    func setScrollBlock(block:@escaping (UIScrollView,scrollState) -> Void) {
        scrollBlock = block
    }
    
    func setCellBlock(block:@escaping (IndexPath) -> Void) {
        cellClickBlock = block
    }
    
    func setSearchBlock(block:@escaping (String) -> Void) {
        searchBlock = block
    }
    
    func setOnOffBtnBlock(block:@escaping (Bool,IndexPath) -> Void) {
        onOffBtnBlock = block
    }
    
    func reloadCollectionView() {
        if let collectionView = collectionView {
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
    
    func reloadCollectionViewAtRow(row:Int ,atSection:Int) {
        if let collectionView = collectionView {
            DispatchQueue.main.async {
                let indexPath = IndexPath(item: row, section: atSection)
                UIView.performWithoutAnimation {
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
    
    func reloadCollectionViewAtRows(rows:[Int] ,atSection:Int) {
        if let collectionView = collectionView {
            var indexArr:[IndexPath] = []
            for row in rows {
                indexArr.append( IndexPath(item: row, section: atSection))
            }
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    collectionView.reloadItems(at: indexArr)
                }
            }
        }
    }
    
    func reloadCollectionViewAtSection(section:IndexSet) {
        if let collectionView = collectionView {
            DispatchQueue.main.async {
                collectionView.reloadSections(section)
            }
        }
    }
    
    func searchItemCheck() -> Int {
        return (isSearchItem ? 1:0)
    }
    
    func setData(section:Int,data:[Any]) {
        
        self.datas[section] = data
        self.reloadCollectionView()
    }
    
    func setDataWithOutLoad(section:Int,data:[Any]) {
        self.datas[section] = data
    }
    
    func changeData(section:Int, data:[Any]) {
        if self.getSectionCnt() == 1 {
            self.datas[0] = data
        }else if getSectionCnt() > 1{
            self.datas[section] = data
        }
        self.reloadCollectionView()
    }
    
    public func hasData() ->Bool {
        return (self.datas.count != 0)
    }
    
    public func haseDataAtSection(section:Int) -> Bool {
        return (String(describing:self.datas[section]) != "noitem")
    }
    
    public func getIndexPathDataAt(indexPath:IndexPath) -> Any? {
        if let dataRowArr = self.datas[indexPath.section] {
            if let rowArr = dataRowArr {
                return rowArr[indexPath.row]
            }
        }
        return nil
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.getSectionCnt()
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = self.datas[section], data!.count > 0 {
            let cnt = data!.count
            return cnt
        }
        return 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let block = cellClickBlock {
                block(indexPath)
            }
        }
    
    
}

extension BaseCollectionAdapter: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let block = self.scrollBlock {
            block(scrollView,.SCROLL_END_DECELERATING)
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let block = self.scrollBlock {
            block(scrollView,.SCROLL_DID_SCROLLING)
        }
    }
    
    
}



