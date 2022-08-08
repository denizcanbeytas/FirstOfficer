//
//  OfficesTableViewCell.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import UIKit
import SDWebImage

class OfficesTableViewCell: UITableViewCell {

    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(viewModel: Offices.Fetch.ViewModel.Office) {
        adressLabel.text = viewModel.address
        nameLabel.text = viewModel.name
        cellImage.sd_setImage(with: URL(string: viewModel.image ?? ""))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
