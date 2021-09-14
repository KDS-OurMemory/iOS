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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func onReadyPushVC() {
        if self.loginCtl == nil {
            self.prepareView()
        }
    }
    
    func prepareView() {
        loginCtl = (CtlMaker().createDataControllerWithContract(contract: ctls.eContractLogin, view: self) as? LoginContract)
    }

    @IBAction func loginForKakaoBtnClick(_ sender: Any) {
        if let ctl = self.loginCtl {
            ctl.tryAutoLoginRequestLogin(type:SNSTYPE.KAKAO)
        }
    }
}

extension LoginViewController: LoginView {
    
    func showNEXTVC(vc: NEXTVIEW, data: [NSObject]?) {
        switch vc {
        case NEXTVIEW.NEXTVIEW_MAIN:
            self.navigate(NEXTVIEW.NEXTVIEW_MAIN)
            break
        default:
            break
        }
    }
    
    func showSignUpView(snsType:SNSTYPE) {
        self.signUpVC.initWithCallBack(snsType: snsType, callback: { valideCase in
            switch valideCase {
            case .SUCCESS:
                if let ctl = self.loginCtl {
                    ctl.tryLoginRequest()
                }
                break
            case .CANCEL:
                break
            case .FAILE:
                break
            }
        })
        
        switch snsType {
        case .KAKAO:
            KaKaoLoginWrapper.shared.tryKakaoLogin { flag in
                self.present(self.signUpVC, animated: true)
            }
            break
        case .GOOGLE:
            break
        case .NAVER:
            break
        }
    }
    
}
