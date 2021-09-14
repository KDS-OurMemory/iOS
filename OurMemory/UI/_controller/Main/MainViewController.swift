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
    
    var mainCtl:MainContract?
    var mainCollectionCtl:weekCollectionCtl = weekCollectionCtl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func onReadyPushVC() {
        if self.mainCtl == nil {
            self.prepareView()
        }
        if let ctl = self.mainCtl {
            ctl.tryGetMyRommListRequest()
        }
    }

    
    private func prepareView() {
        mainCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMain, view: self) as? MainContract
        if let ctl = self.mainCtl {
            ctl.setCollectionView(collection: roomCollectionView, collectionCtl: self.mainCollectionCtl)
        }
    }
    

}

extension MainViewController: MainView {
    func showNEXTVC(vc: NEXTVIEW, data: [NSObject]?) {
        
    }
    
    func reloadCollectionView() {
        self.roomCollectionView.reloadData()
    }
}
