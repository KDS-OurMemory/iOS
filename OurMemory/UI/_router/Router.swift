//
//  Router.swift
//  OurMemory
//
//  Created by 이승기 on 2022/01/27.
//

import Foundation
import UIKit

// MARK: UIViewController Router

struct MyAppNavigation: AppNavigation {
    
    static let tabbarView:TabbarView = TabbarView()
    static var tabbarIsOpen:Bool = false
    
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController,animation:Bool,data: Any?) {
        if (navigation as? NEXTVIEW) == NEXTVIEW.NEXTVIEW_POP {
            if let navi = from.navigationController {
                navi.popViewController(animated: animation)
                if navi.viewControllers.contains(from) {
                    navi.viewControllers.remove(at: (navi.viewControllers.firstIndex(of: from))!)
                }
            }
            return
        }
        if let view = to as? ViewContract {
            view.prepareViewWithData(data: data)
            if (navigation as? NEXTVIEW) == .NEXTVIEW_MAIN ||
                        (navigation as? NEXTVIEW) == .NEXTVIEW_MYMEMORY ||
                        (navigation as? NEXTVIEW) == .NEXTVIEW_OURMEMORY ||
                        (navigation as? NEXTVIEW) == .NEXTVIEW_MYPROFILE {
                if let tabView = view as? TabbarContract {
                    tabView.setTabbarView(tabView: MyAppNavigation.tabbarView)
                    guard let context = tabView as? UIViewController else { return }
                    MyAppNavigation.tabbarView.setContext(context: context)
                    MyAppNavigation.tabbarView.initViewWithCallback { p1 in
                        switch p1 {
                        case .home:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_MAIN, animation:false,data: nil,  onInitVc:nil)
                            break
                        case .category:
                            MyAppNavigation.tabbarIsOpen = !MyAppNavigation.tabbarIsOpen
                            MyAppNavigation.tabbarView.updateTabViewState(open: MyAppNavigation.tabbarIsOpen)
                            break
                        case .myMemory:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_MYMEMORY,animation:false, data: nil, onInitVc:nil)
                            break
                        case .ourMemory:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_OURMEMORY, animation:false,data: nil, onInitVc:nil)
                            break
                        case .myProfile:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_MYPROFILE, animation:false, data: nil, onInitVc:nil)
                            break
                        case .schdule:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_SCHEDULE, animation:false, data: nil, onInitVc:nil)
                            break
                        case .frieand:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_FRIENDSLIST, animation:false, data: nil, onInitVc:nil)
                            break
                        case .todoList:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_TODOLIST, animation:false, data: nil, onInitVc:nil)
                            break
                        case .butkitList:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_BUTKITLIST, animation:false, data: nil, onInitVc:nil)
                            break
                        case .noti:
                            MyAppNavigation.tabbarView.context.navigate(NEXTVIEW.NEXTVIEW_NOTI, animation:false, data: nil, onInitVc:nil)
                            break
                        default:
                            break
                        }
                    }
                }
                
            }
            else if let popView = view as? PopupContract {
                (popView as! UIViewController).modalPresentationStyle = .overFullScreen
                from.present(popView as! UIViewController, animated: false) {
                    popView.prepareViewWithData(data: data)
                }
                
                
                return
            }
        }
        
        from.navigationController?.pushViewController(to, animated: animation)
        
    }
    
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        
        if let navigation = navigation as? NEXTVIEW {
            switch navigation {
            case .NEXTVIEW_LOGIN:
                return LoginViewController().initiailizeSubViewClass()
            case .NEXTVIEW_SIGNUP:
                return SignUpViewController().initiailizeSubViewClass()
            case .NEXTVIEW_MAIN:
                return MainViewController().initiailizeSubViewClass()
            case .NEXTVIEW_FRIENDSLIST:
                return SharedListViewController().initiailizeSubViewClass()
            case .NEXTVIEW_ROOMLIST:
                return RoomTableViewController().initiailizeSubViewClass()
//            case .NEXTVIEW_ROOMDETAIL:
//                return RoomDetailViewController().initiailizeSubViewClass()
            case .NEXTVIEW_SCHEDULE:
                return ScheduleViewController().initiailizeSubViewClass()
            case .NEXTVIEW_TODOLIST:
                return TodoListViewController().initiailizeSubViewClass()
            case .NEXTVIEW_MYMEMORY:
                return MyMemoryViewController().initiailizeSubViewClass()
            case .NEXTVIEW_OURMEMORY:
                return OurMemoryViewController().initiailizeSubViewClass()
            case .NEXTVIEW_ADDSCHEDULE:
                return AddSchduleViewController().initiailizeSubViewClass()
            case .NEXTVIEW_SELECTCOLOR:
                return SelectColorViewController().initiailizeSubViewClass()
            case .NEXTVIEW_SELECTSHARED:
                return SelectSharedViewController().initiailizeSubViewClass()
            case .NEXTVIEW_SELECTALRAMTIME:
                return SelectAlramTimeViewController().initiailizeSubViewClass()
            case .NEXTVIEW_SELECTDATE:
                return SelectDateViewController().initiailizeSubViewClass()
            case .NEXTVIEW_MYPROFILE:
                return MyProfileViewController().initiailizeSubViewClass()
            default:
                break
            }
            
        }
        return UIViewController()
    }
}

class Router {
    public static let defaultRouter:DefaultRouter = DefaultRouter()
}

public protocol AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController,animation:Bool,data:Any?)
}

public protocol IsRouter {
    func setupAppNavigation(appNavigation: AppNavigation)
    func navigate(_ navigation: Navigation, from: UIViewController, animation:Bool,  data:Any? , onInitVc:( (UIViewController) -> Void)?)
    func didNavigate(block: @escaping (Navigation,Any?) -> Void)
    var appNavigation: AppNavigation? { get }
}

public extension UIViewController {
    func navigate(_ navigation: Navigation,animation:Bool, data:Any?, onInitVc: ( (UIViewController) -> Void)? ) {
        Router.defaultRouter.navigate(navigation, from: self,animation:animation, data:data, onInitVc: onInitVc)
    }
    
}

public class DefaultRouter: IsRouter {
    
    public var appNavigation: AppNavigation?
    var didNavigateBlocks = [((Navigation,Any?) -> Void)] ()
    
    public func setupAppNavigation(appNavigation: AppNavigation) {
        self.appNavigation = appNavigation
    }
    
    public func navigate(_ navigation: Navigation, from: UIViewController,animation:Bool, data:Any?, onInitVc:( (UIViewController) -> Void)?) {
        
        DispatchQueue.main.async {
            guard let toVC = self.appNavigation?.viewcontrollerForNavigation(navigation: navigation) else { return }
            var isContainNaviToVC = false
            if let navi = from.navigationController{
                var visibleView:UIViewController!
                for vc in navi.viewControllers {
                    isContainNaviToVC = (type(of: vc) === type(of: toVC))
                    if isContainNaviToVC {
                        visibleView = vc
                        break
                    }
                }
                if isContainNaviToVC {
                    navi.viewControllers.remove(at: navi.viewControllers.firstIndex(of: visibleView)!)
                    self.appNavigation?.navigate(navigation, from: from, to: visibleView,animation:animation,data: data)
                    if let initCallback = onInitVc {
                        initCallback(visibleView)
                    }
                }else {
                    self.appNavigation?.navigate(navigation, from: from, to: toVC,animation:animation,data: data)
                    if let initCallback = onInitVc {
                        initCallback(toVC)
                    }
                }
            }
        }

        //                for b in didNavigateBlocks {
        //                    b(navigation,toVC)
        //                }
        
        
        
        
    }
    
    public func didNavigate(block: @escaping (Navigation,Any?) -> Void) {
        didNavigateBlocks.append(block)
    }
}

// Injection helper
public protocol Initializable { init() }
open class RuntimeInjectable: NSObject, Initializable {
    public required override init() {}
}

public func appNavigationFromString(_ appNavigationClassString: String) -> AppNavigation {
    let appNavClass = NSClassFromString(appNavigationClassString) as! RuntimeInjectable.Type
    let appNav = appNavClass.init()
    return appNav as! AppNavigation
}
