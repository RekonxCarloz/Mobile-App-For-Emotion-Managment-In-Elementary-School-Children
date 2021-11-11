//
//  GridCollectionViewCell.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 11/11/21.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {

    static let cellId = "GridCell"

    private let animationScaleFactor: CGFloat = 1.5

    @IBOutlet weak var label: UILabel!

    override var isSelected: Bool {
        didSet {
            // Scale up the letter if it's selected.
            let transform = isSelected ? CGAffineTransform(scaleX: animationScaleFactor, y: animationScaleFactor) : .identity
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: [], animations: {
                self.label.transform = transform
            }) { (_) in }
        }
    }
}
