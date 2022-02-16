//
//  MainViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var weekCollectionView: UICollectionView!
    @IBOutlet var roomCollectionView: UICollectionView!
    @IBOutlet weak var nowPlanLbl: UILabel!
    @IBOutlet weak var nextPlanLbl: UILabel!
    var tabbar:TabbarView!
    
    var mainCtl:MainContract?
    var mainCollectionCtl:weekCollectionCtl = weekCollectionCtl()
    
    override func getDataContract() -> DataContract? {
        return self.mainCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            mainCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMain, view: self, data: data) as? MainContract
        }
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        
        switch vc {
        default:
            break
        }
    }

}

extension MainViewController: MainView {
    
    func updateNotiCnt(items: [UInt : Int]) {
        if let tabbar = self.tabbar {
            tabbar.updateNotiItemWithCnt(items: items)
        }
    }
    
    func setTabbarView(tabView: UIView) {
        if let tabbar = tabView as? TabbarView {
            self.tabbar = tabbar
            self.view.addSubview(tabView)
        }
    }
    
    func reloadCollectionView() {
        self.roomCollectionView.reloadData()
    }
}
