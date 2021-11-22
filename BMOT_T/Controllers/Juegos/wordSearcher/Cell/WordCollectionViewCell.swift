//
//  WordCollectionViewCell.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 11/11/21.
//

import UIKit

class WordCollectionViewCell: UICollectionViewCell {

    static let cellId = "WordCell"
    var palabrasEncontradas = 0
    
    @IBOutlet weak var label: UILabel!

    func configure(with text: String, selected: Bool) {
        if selected {
            // Strike through the word if it's selected.
            let attrString = NSMutableAttributedString(string: text)
            let attrsDict = [
                NSAttributedString.Key.strikethroughStyle: 2,
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
                ] as [NSAttributedString.Key : Any]
            attrString.addAttributes(attrsDict, range: NSRange(location: 0, length: text.count))
            label.attributedText = attrString
            
        } else {
            label.text = text
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 13)
        }
        
        label.backgroundColor = isSelected ? UIColor.gray.withAlphaComponent(0.5) : UIColor.clear
    }
}
