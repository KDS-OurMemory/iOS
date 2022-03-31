//
//  TodoListItemView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/18.
//

import UIKit

class TodoListItemView: BaseView {

    let dateLbl = UILabel()
    let itemContainer = BaseView()
    
    override func prepareViews() {
        let itemHeight = 50.0
        dateLbl.frame = CGRect(x: 0, y: 0, width: mainWidth, height: itemHeight)
        itemContainer.frame = CGRect(x: 0, y: itemHeight + 10, width: mainHeight, height: 0)
        
        self.addSubview(self.dateLbl)
        self.addSubview(self.itemContainer)
    }

    func setData(data:ToDoListDataBinder) {
        dateLbl.text = data.getDate()
        
        for item in data.getItems() {
            let itemBtn = UIButton()
            self.itemContainer.addVerSubView(subView: itemBtn, viewHeight: itemBtn.frame.height, verPadding: 10)
        }
    }
    
}
