//
//  FullScreenCollectionViewCell.swift
//  FirstOfficer
//
//  Created by Deniz on 10.08.2022.
//

import UIKit
import SDWebImage

class FullScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(images: String){
        imageView.sd_setImage(with: URL(string: images))
        
        
        
//        for imageSingle in viewModel.images! {
//            imageView.sd_setImage(with: URL(string: imageSingle))
//        }
    }
    
//    func configureCell(image: String){
//        imageView.image = UIImage(named: image)
//    }
    
    

}
