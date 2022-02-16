//
//  tabbarView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/01/27.
//

import Foundation
import UIKit

class TabbarBtnView:BaseView {
    let tabBarBtn:UIButton = UIButton()
    let tabBarTitleLbl:UILabel = UILabel()
    let notiCntLbl:UILabel = UILabel()
    var tabBtnBlock:((Int) -> Void)!
    var tabBtnPOIY:CGFloat!
    var tabLblPOIY:CGFloat!
    
    override func prepareViews() {
        tabBarBtn.center = self.center
        tabBarBtn.frame.size = CGSize(width: self.frame.size.width, height: self.frame.size.height * 0.6)
        tabBarBtn.addTarget(self, action:#selector(clickedTabBtn(btn:)), for: .touchUpInside)
        tabBtnPOIY = tabBarBtn.frame.origin.y
        
        tabBarTitleLbl.frame = CGRect(x: tabBarBtn.frame.origin.x, y: tabBarBtn.frame.origin.y+tabBarBtn.frame.size.height, width: tabBarBtn.frame.width, height: 0)
        tabBarTitleLbl.textAlignment = .center
        tabLblPOIY = tabBarTitleLbl.frame.origin.y
        
        notiCntLbl.frame = CGRect(x: tabBarBtn.frame.size.width - self.frame.size.width * 0.35, y: tabBtnPOIY, width: self.frame.size.width * 0.35, height: self.frame.size.width * 0.35)
        notiCntLbl.layer.cornerRadius = 50
        notiCntLbl.layer.backgroundColor = UIColor.red.cgColor
        notiCntLbl.textColor = .white
        notiCntLbl.textAlignment = .center
    }
    
    func setTabBtnBlock(block :@escaping (Int) -> Void) {
        self.tabBtnBlock = block
    }
    
    func setBtnImage(normalImage:UIImage?,selectedImage:UIImage?) {
        
        tabBarBtn.setImage(normalImage, for: .normal)
        tabBarBtn.setImage(selectedImage, for: .selected)
    }
    
    func setTitle(title:String) {
        tabBarTitleLbl.text = title;
    }
    
    func setNotiCnt(count:Int) {
        notiCntLbl.isHidden = (count == 0 ? true:false)
        notiCntLbl.text = "\(count)"
    }
    
    fileprivate func updateSelectTabBtn(selected:Bool) {
        let btnY = selected==true ? 0:tabBtnPOIY
        let lblY = selected==true ? tabBarBtn.frame.size.width:tabLblPOIY
        let notiCntY = selected==true ? 0:tabBtnPOIY
        let lblH = selected==true ? self.frame.size.height * 0.2:0
        
        tabBarBtn.frame.origin.y = btnY!
        tabBarTitleLbl.frame.origin.y = lblY!
        tabBarTitleLbl.frame.size.height = lblH
        notiCntLbl.frame.origin.y = notiCntY!
    }
    
    @objc private func clickedTabBtn(btn:UIButton) {
        self.updateSelectTabBtn(selected: btn.isSelected)
        self.tabBtnBlock(self.tag)
    }
}

class TabbarView:BaseView {
    let tabBtnView:UIView = UIView()
    let categoryView:UIView = UIView()
    var tabbarBtns:[TabbarBtnView] = []
    var categoryBtns:[TabbarBtnView] = []
    var tabBtnBlock:((TabItems) -> Void)!
    var context:UIViewController!
    
    override func prepareViews() {
        
        let categoryViewHeight:CGFloat = tabbarHeight * 2
        
        
        self.frame = CGRect(x: 0, y: mainHeight-tabbarHeight, width: mainWidth, height: tabbarHeight)
        
        self.tabBtnView.frame = CGRect(x:0, y:0,width: mainWidth,height: tabbarHeight)
        self.addSubview(tabBtnView)
        
        categoryView.frame = CGRect(x: 0, y: tabbarHeight, width: mainWidth, height: categoryViewHeight)
        self.addSubview(categoryView)
        
        self.makeTabbarItems(items: [.home,.category,.myMemory,.ourMemory,.myProfile])
        self.makeTabCategoryItems(items: [.schdule,.frieand,.todoList,.butkitList,.noti])
    }
    
    func initViewWithCallback(callback: @escaping (TabItems) -> Void) {
        self.tabBtnBlock = callback
    }
    
    func setContext(context:UIViewController) {
        self.context = context
    }
    
    func updateNotiItemWithCnt(items:[UInt:Int]) {
        for (item,cnt) in items {
            if let view = viewWithTag(Int(item)) as? TabbarBtnView {
                let key = TabItems(rawValue: item)
                switch key {
                case .home,.category,.myMemory,.ourMemory,.myProfile:
                    if tabbarBtns.contains(view) {
                        view.setNotiCnt(count: cnt)
                    }
                    break
                case .schdule,.frieand,.todoList,.butkitList,.noti:
                    if categoryBtns.contains(view) {
                        view.setNotiCnt(count: cnt)
                    }
                    break
                default:
                    break
                }
            }
        }
    }
    
    private func makeTabbarItems(items:TabItems) {
        let tabBtnWidth:CGFloat = mainWidth*0.2
        let tabbarHeight:CGFloat = 70.0
        for item in items.elements() {
            let tabBtnCnt = self.tabBtnView.subviews.count
            let tabbarBtnView:TabbarBtnView = TabbarBtnView(frame: CGRect(x: CGFloat(tabBtnCnt)*tabBtnWidth, y: 0, width: tabBtnWidth, height: tabbarHeight))
            tabbarBtnView.setTitle(title: self.setTabItemTitle(item: item.rawValue))
            tabbarBtnView.setBtnImage(normalImage: self.setTabItemImage(item: item.rawValue), selectedImage: self.setTabItemImage(item: item.rawValue))
            tabbarBtnView.tag = Int(item.rawValue)
            self.tabBtnView.addSubview(tabbarBtnView)
            self.tabbarBtns.append(tabbarBtnView)
            tabbarBtnView.setTabBtnBlock { p1 in
                self.tabBtnBlock(TabItems.init(rawValue: UInt(p1)))
            }
        }
    }
    
    private func makeTabCategoryItems(items:TabItems) {
        let tabBtnWidth:CGFloat = mainWidth*0.25
        let tabbarHeight:CGFloat = 70.0
        for item in items.elements() {
            let tabBtnCnt = self.tabBtnView.subviews.count
            let categoryBtnView:TabbarBtnView = TabbarBtnView(frame: CGRect(x: CGFloat(tabBtnCnt)*tabBtnWidth, y: abs(tabBtnCnt > 4 ? tabbarHeight*CGFloat(Double(tabBtnCnt)*0.25+1.0): 0), width: tabBtnWidth, height: tabbarHeight))
            categoryBtnView.setTitle(title: self.setTabItemTitle(item: item.rawValue))
            categoryBtnView.setBtnImage(normalImage: self.setTabItemImage(item: item.rawValue), selectedImage: self.setTabItemImage(item: item.rawValue))
            categoryBtnView.tag = Int(item.rawValue)
            self.categoryView.addSubview(categoryBtnView)
            self.categoryBtns.append(categoryBtnView)
            categoryBtnView.setTabBtnBlock { p1 in
                self.tabBtnBlock(TabItems.init(rawValue: UInt(p1)))
            }
        }
    }
    
    func updateTabViewState(open:Bool) {
        let tabbarHeight:CGFloat = 70.0
        let categoryViewHeight:CGFloat = tabbarHeight * 2
        self.frame.size.height = (open == true ? tabbarHeight:tabbarHeight + categoryViewHeight)
    }
    
    func setTabItemTitle(item:UInt) -> String {
        var title:String = ""
        switch item {
        case TabItems.home.rawValue:
            title = "홈"
            break
        case TabItems.category.rawValue:
            title = "카테고리"
            break
        case TabItems.myMemory.rawValue:
            title = "나의 기억"
            break
        case TabItems.ourMemory.rawValue:
            title = "우리의 기억"
            break
        case TabItems.myProfile.rawValue:
            title = "마이페이지"
            break
        case TabItems.schdule.rawValue:
            title = "일정"
            break
        case TabItems.frieand.rawValue:
            title = "친구"
            break
        case TabItems.todoList.rawValue:
            title = "To-Do List"
            break
        case TabItems.butkitList.rawValue:
            title = "버킷리스트"
            break
        case TabItems.noti.rawValue:
            title = "알림"
            break
        default:
            break
        }
        return title
    }
    
    func setTabItemImage(item:UInt) -> UIImage? {
        var imgName:String = ""
        switch item {
        case TabItems.home.rawValue:
            imgName = ""
            break
        case TabItems.category.rawValue:
            imgName = ""
            break
        case TabItems.myMemory.rawValue:
            imgName = ""
            break
        case TabItems.ourMemory.rawValue:
            imgName = ""
            break
        case TabItems.myProfile.rawValue:
            imgName = ""
            break
        case TabItems.schdule.rawValue:
            imgName = ""
            break
        case TabItems.frieand.rawValue:
            imgName = ""
            break
        case TabItems.todoList.rawValue:
            imgName = ""
            break
        case TabItems.butkitList.rawValue:
            imgName = ""
            break
        case TabItems.noti.rawValue:
            imgName = ""
            break
        default:
            break
        }
        let itemImg:UIImage? = UIImage(named: imgName)
        
        return itemImg
    }
    
}
