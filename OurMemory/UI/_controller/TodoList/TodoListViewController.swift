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
    let insertPopup:InsertTodoPopupView = InsertTodoPopupView()
    let addBtn:UIButton = UIButton()
    @IBOutlet weak var todoListItemSv: UIScrollView!
    @IBOutlet weak var todoListBtnContainer: UIView!
    
    
    override func getDataContract() -> DataContract? {
        return self.todoListCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            let addBtnSize = CGSize(width: 60.0, height: 60.0)
            let lineHieght = 2.0
            let leftMaxX = todoListBtnContainer.center.x-addBtnSize.width/2
            let lineColor = UIColor.lightGray.cgColor
            let padding = 5.0
            let lineY = 0.0
            
            addBtn.frame.size = CGSize(width: addBtnSize.width, height: addBtnSize.height)
            addBtn.center = CGPoint(x: todoListBtnContainer.center.x, y: todoListBtnContainer.frame.minY)
            
            topViewContainer.addSubview(topView)
            topView.setTitle(title: "To-Do List")
            
            topView.setLeftBtn(btnTitle: nil, btnImage: UIImage(systemName: "chervon.left")) {
                self.showNextVC(vc: .NEXTVIEW_POP, data: nil)
            }
            
            let leftPath = UIBezierPath()
            leftPath.move(to: CGPoint(x: padding, y: lineY))
            leftPath.addLine(to: CGPoint(x:leftMaxX - padding ,y:lineY))
            leftPath.lineWidth = lineHieght
            
            let leftShapeLayer:CAShapeLayer = CAShapeLayer()
            leftShapeLayer.path = leftPath.cgPath
            leftShapeLayer.lineWidth = leftPath.lineWidth
            leftShapeLayer.fillColor = UIColor.clear.cgColor
            leftShapeLayer.strokeColor = lineColor
            
            todoListBtnContainer.layer.addSublayer(leftShapeLayer)
            leftPath.close()
            
            let centerPath = UIBezierPath()
            centerPath.move(to: CGPoint(x: leftMaxX - padding, y: lineY))
            centerPath.addCurve(to: CGPoint(x: leftMaxX+addBtnSize.width + padding, y: lineY), controlPoint1: CGPoint(x: leftMaxX, y: lineY+addBtnSize.height/2 + padding), controlPoint2: CGPoint(x: leftMaxX+addBtnSize.width, y: lineY+addBtnSize.height/2 + padding))
            centerPath.lineWidth = lineHieght
            
            let centerShapeLayer:CAShapeLayer = CAShapeLayer()
            centerShapeLayer.path = centerPath.cgPath
            centerShapeLayer.lineWidth = centerPath.lineWidth
            centerShapeLayer.fillColor = UIColor.clear.cgColor
            centerShapeLayer.strokeColor = lineColor

            todoListBtnContainer.layer.addSublayer(centerShapeLayer)
            centerPath.close()
            
            let rightPath = UIBezierPath()
            rightPath.move(to: CGPoint(x: leftMaxX+addBtnSize.width + padding, y: lineY))
            rightPath.addLine(to: CGPoint(x: mainWidth - padding*2,y:lineY))
            rightPath.lineWidth = lineHieght
            
            let rightShapeLayer:CAShapeLayer = CAShapeLayer()
            rightShapeLayer.path = rightPath.cgPath
            rightShapeLayer.lineWidth = rightPath.lineWidth
            rightShapeLayer.fillColor = UIColor.clear.cgColor
            rightShapeLayer.strokeColor = lineColor
            
            todoListBtnContainer.layer.addSublayer(rightShapeLayer)
            rightPath.close()
            
            self.view.addSubview(addBtn)
            
            addBtn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            
            todoListCtl = CtlMaker().createDataControllerWithContract(contract: .eContractTodoList, view: self, data: data) as? TodoListContract
            
        }else {
            if let ctl = self.getDataContract() as? TodoListContract {
                ctl.setSelectDate(date:data as! String)
            }
        }
    }
    
    

}

extension TodoListViewController: TodoListView {
    func showInsertPopup() {
        
    }
}
