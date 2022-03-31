//
//  TodoListCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class TodoListCtl: BaseCollectionCtl {
    
    let todoListModel:TodoListModel = TodoListModel()
    let dateModel:DateComponentsModel = DateComponentsModel()

    override func __initWithData__(data: Any?) {
        
        
    }
    
    
    
}

extension TodoListCtl:TodoListContract {
    
    func setSelectDate(date:String) {
        
    }
    
    func actionMenuBtn() {
        if let view = self.view as? TodoListView {
            view.showActionSheetWithTitleAndActions(title: "할일", msg: "", actions: [
                "앞으로 할 일":{ p1 in
                
            },
                "오늘 할 일":{ p1 in
                    
                },
                "모든 할 일":{ p1 in
                    
                }])
        }
    }
    
}
