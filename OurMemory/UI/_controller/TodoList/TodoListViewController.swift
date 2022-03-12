//
//  TodoListViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class TodoListViewController: BaseViewController {

    @IBOutlet weak var topViewContainer: UIView!
    let topView:TopView = TopView()
    var todoListCtl:TodoListContract?
    @IBOutlet weak var todoListItemSv: UIScrollView!
    
    
    override func getDataContract() -> DataContract? {
        return self.todoListCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            
            topViewContainer.addSubview(topView)
            topView.setTitle(title: "")
            
            todoListCtl = CtlMaker().createDataControllerWithContract(contract: .eContractTodoList, view: self, data: data) as? TodoListContract
        }
    }
    
    

}

extension TodoListViewController: TodoListView {
    
}
