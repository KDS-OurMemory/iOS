//
//  SearchCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/20.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var searchTf: UITextField!
    var searchBlock:((String) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        searchTf.delegate = self
        searchTf.isUserInteractionEnabled = true
    }

    func setSearchBlock(block:@escaping (String) -> Void) {
        searchBlock = block
    }
    
    func changeOpenSearchCell(state:Bool) {
        self.isHidden = !state
        self.isUserInteractionEnabled = state
    }
    
    func setPlaceholder(placeholder:String) {
        searchTf.placeholder = placeholder
    }

}

extension SearchCollectionViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let block = self.searchBlock,let text = textField.text {
            block(text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
