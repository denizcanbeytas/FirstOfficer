//
//  OfficeDetailCollectionViewCell.swift
//  FirstOfficer
//
//  Created by Deniz on 8.08.2022.
//

import UIKit
import SDWebImage

class OfficeDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(images: String) {
        imageView.sd_setImage(with: URL(string: images))
    }
}
