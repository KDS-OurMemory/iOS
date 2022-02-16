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
    
    override func getDataContract() -> DataContract? {
        return self.selectColorCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            selectColorCtl = CtlMaker().createDataControllerWithContract(contract: .eContractSelectColor, view: self, data: data) as? SelectColorContract
        }
        itemWidth = colorContainer.frame.width * 0.2
        itemHeight = colorContainer.frame.height * 0.33
    }
    
    func setSelectColorBlock(block: @escaping (UIColor) -> Void) {
        selectColorBlock = block
    }
    
    fileprivate func applySelectColor(color: UIColor) {
        if let block = self.selectColorBlock {
            block(color)
            self.showNextVC(vc: .NEXTVIEW_POP, data: nil)
        }
    }

}

extension SelectColorViewController: SelectColorView {
    func updateColors(colors: [UIColor]) {
        for color in colors {
            let idx = Double(colors.firstIndex(of: color)!)
            let colorItem:ColorItemView = ColorItemView(frame: CGRect(x: itemWidth*(idx.truncatingRemainder(dividingBy: 5.0)), y: itemHeight*(idx*0.2), width: itemWidth, height: itemHeight))
            colorItem.setSelectColorBtnBlock { p1 in
                self.applySelectColor(color: p1)
            }
        }
    }
    
    
    
    
}
