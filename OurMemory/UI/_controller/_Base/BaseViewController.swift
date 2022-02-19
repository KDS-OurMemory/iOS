//
//  BaseViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/03/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        } 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .white
    }
    
    func initiailizeSubView() -> Self {
        
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func initiailizeSubViewClass() -> Self {
        
        func loadNibInViewController<T: UIViewController>() -> T {
            let nib = UINib(nibName: String(describing:T.self), bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as! T
        }
        
        return loadNibInViewController()
    }
    
    func getDataContract() -> DataContract? {
        return nil
    }
    
    func setBackgroundDimColor() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    
    func setBackgroundWhiteColor() {
        self.view.backgroundColor = .white
    }
    
    func prepareViewWithData(data: Any?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showNextVC(vc: NEXTVIEW, data: Any?) {
        
    }
    
    func showNetworkErrorAlert() {
        let alertCtl:UIAlertController = UIAlertController(title: "", message: "네트워크 연결이 원할하지 않습니다.", preferredStyle: UIAlertController.Style.alert)
        alertCtl.show(self, sender: self);
    }
    
    func showAlertMsgWithTitle(title:String,msg:String) {
        let alertCtl:UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertCtl.show(self, sender: self);
    }
    
    func showAlertMsgWithTitleAndActions(title:String,msg:String, actions: [String:(UIAlertAction) -> Void]) {
        var alertActions:[UIAlertAction] = []
        for (key,action) in actions {
            let action:UIAlertAction = UIAlertAction(title: key, style: .default, handler: action)
            alertActions.append(action)
        }
        let alertCtl:UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        for alertAction in alertActions {
            alertCtl.addAction(alertAction)
        }
        self.present(alertCtl, animated: false, completion: nil)
    }
    
    func showFadeOutMsgView(msg:String) {
        let msgView:FadeView = FadeView(frame: CGRect.zero)
        msgView.setMsg(msg: msg)
        self.view.addSubview(msgView)
        msgView.fadeIn()
        msgView.fadeOut()
        
    }

}
