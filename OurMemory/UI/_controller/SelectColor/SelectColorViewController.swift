//
//  SelectColorViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit
import OurMemoryTask

class SelectColorViewController: BaseViewController {

    var selectColorCtl:SelectColorContract?
    var selectColorBlock:((UIColor) -> Void)?
    
    @IBOutlet weak var colorContainer: UIView!
    var itemWidth = 0.0
    var itemHeight = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackgroundDimColor()
    }
    
    override func getDataContract() -> DataContract? {
        return self.selectColorCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            selectColorCtl = CtlMaker().createDataControllerWithContract(contract: .eContractSelectColor, view: self, data: data) as? SelectColorContract
        }
        itemWidth = colorContainer.frame.width * 0.2
        itemHeight = colorContainer.frame.height/3
        
    }
    
    func setSelectColorBlock(block: @escaping (UIColor) -> Void) {
        selectColorBlock = block
    }
    
    fileprivate func applySelectColor(color: UIColor) {
        if let block = self.selectColorBlock {
            block(color)
            self.dismissPopup()
        }
    }

}

extension SelectColorViewController: SelectColorView {
    func updateColors(colors: [UIColor]) {
        for colorView in colorContainer.subviews {
            colorView.removeFromSuperview()
        }
        for color in colors {
            let cnt = colorContainer.subviews.count
            let colorItem:ColorItemView = ColorItemView()
            colorContainer.addSubview(colorItem)
            colorItem.frame = CGRect(x: itemWidth*CGFloat(cnt%5), y: itemHeight*CGFloat((cnt/5)), width: itemWidth, height: itemHeight)
            colorItem.setCornerRadius(radius: itemWidth/2)
            colorItem.setColor(color: color)
            colorItem.setSelectColorBtnBlock { p1 in
                self.applySelectColor(color: p1)
            }
        }
    }
    
    func dismissPopup() {
        self.dismiss(animated: true) {
        }
    }
    
    
}
