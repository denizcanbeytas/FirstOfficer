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
    @IBOutlet weak var contentsView: UIView!
    
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var heartBtnIsTapped : Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    @IBAction func favoriteClicked(_ sender: Any) {
       
        if heartBtnIsTapped == true {
            favoriteImage.image = UIImage(named: "FavoriteClicked")
            heartBtnIsTapped = false
        }else {
            favoriteImage.image = UIImage(named: "FavoriteUnClicked")
            heartBtnIsTapped = true
        }
        // or you can use this
//        if favoriteBtn.tag == 0 {
//            favoriteImage.image = UIImage(named: "FavoriteUnClicked")
//            favoriteBtn.tag = 1
//        } else {
//            favoriteImage.image = UIImage(named: "FavoriteClicked")
//            favoriteBtn.tag = 0
//        }
    }
    
    func config(viewModel: Offices.Fetch.ViewModel.Office) {
        adressLabel.text = viewModel.address
        nameLabel.text = viewModel.name
        capacityLabel.text = viewModel.capacity
        roomsLabel.text = viewModel.rooms
        spaceLabel.text = viewModel.space
        cellImage.sd_setImage(with: URL(string: viewModel.image ?? ""))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        contentsView.layer.cornerRadius = 18
        contentsView.layer.masksToBounds = false
        contentsView.layer.shadowColor = UIColor.black.cgColor
        contentsView.layer.shadowOpacity = 0.2
        contentsView.layer.shadowOffset = .zero
        contentsView.layer.shadowRadius = 3

    }
    
}
