//
//  FriendViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/03/22.
//

import UIKit
import OurMemoryTask

class SharedListViewController: BaseViewController {

    var sharedListCtl:SharedListContract?
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var tabViewContainer: UIView!
    @IBOutlet weak var sharedListCollectionView: UICollectionView!
    
    override func getDataContract() -> DataContract? {
        return self.sharedListCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            sharedListCtl = CtlMaker().createDataControllerWithContract(contract: .eContractSharedList, view: self, data: data) as? SharedListContract
        }
    }

}

extension SharedListViewController: SharedListView {
    
}
