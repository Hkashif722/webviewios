//
//  CollectionViewCell.swift
//  AutoLayout1
//
//  Created by Asif on 25/09/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var lblCountryName: UILabel!
    
    func configure(with countryName: String) {
        lblCountryName.text = countryName
    }
}
