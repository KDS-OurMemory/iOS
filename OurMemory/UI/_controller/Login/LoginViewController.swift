//
//  LoginViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit
import OurMemoryTask

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    
    var loginCtl:LoginContract?
    let signUpVC:SignUpViewController = SignUpViewController().initiailizeSubViewClass()

    override func getDataContract() -> DataContract? {
        return self.loginCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            loginCtl = (CtlMaker().createDataControllerWithContract(contract: ctls.eContractLogin, view: self,data: data) as? LoginContract)
        }
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_SIGNUP:
            self.navigate(NEXTVIEW.NEXTVIEW_SIGNUP, data: data)
            break
        case .NEXTVIEW_MAIN:
            self.navigate(NEXTVIEW.NEXTVIEW_MAIN, data: data)
            break
        default:
            break
        }
    }

    @IBAction func loginForKakaoBtnClick(_ sender: Any) {
        if let ctl = self.loginCtl {
            ctl.startKakaoLoginProccess()
        }
    }
}

extension LoginViewController: LoginView {
    
    func openUrlForSnsLogin(url: URL) -> Bool {
        if let ctl = self.loginCtl {
            return ctl.openUrlForSnsLogin(url: url)
        }
        return false
    }
    
    func showSignUpView(snsType:SNSTYPE) {

        switch snsType {
        case .KAKAO:
            
            break
        case .GOOGLE:
            break
        case .NAVER:
            break
        case .UNOWNED:
            break
        }
    }
    
}
