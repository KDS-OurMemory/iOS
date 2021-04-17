//
//  Router.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/04/17.
//

import UIKit

open class Router {
    public static let defaultRouter:DefaultRouter = DefaultRouter()
}

public protocol AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController)
}

public protocol IsRouter {
    func setupAppNavigation(appNavigation: AppNavigation)
    func navigate(_ navigation: Navigation, from: UIViewController)
    func didNavigate(block: @escaping (Navigation) -> Void)
    var appNavigation: AppNavigation? { get }
}

public extension UIViewController {
    func navigate(_ navigation: Navigation) {
        Router.defaultRouter.navigate(navigation, from: self)
    }
    
}

public class DefaultRouter: IsRouter {
    
    public var appNavigation: AppNavigation?
    var didNavigateBlocks = [((Navigation) -> Void)] ()
    
    public func setupAppNavigation(appNavigation: AppNavigation) {
        self.appNavigation = appNavigation
    }
    
    public func navigate(_ navigation: Navigation, from: UIViewController) {
        if let toVC = appNavigation?.viewcontrollerForNavigation(navigation: navigation) {
            appNavigation?.navigate(navigation, from: from, to: toVC)
            for b in didNavigateBlocks {
                b(navigation)
            }
        }
    }
    
    public func didNavigate(block: @escaping (Navigation) -> Void) {
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
