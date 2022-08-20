//
//  OfficesTableViewCell.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import UIKit
import SDWebImage

protocol addToFavoriteProtocol {
    func addToFavorite(officeResult: Offices.Fetch.ViewModel.Office)
}

protocol removeAtFavoritesProtocol {
    func removeAtFavorites(favoriteId: Int)
}


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
    
    var delegateAdd: addToFavoriteProtocol?
    var delegateRemove: removeAtFavoritesProtocol?
    
    var ViewModel: Offices.Fetch.ViewModel.Office?
    var officeId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    @IBAction func favoriteClicked(_ sender: Any) {
       
        if heartBtnIsTapped == true {
            favoriteImage.image = UIImage(named: "FavoriteClicked")
            heartBtnIsTapped = false
            delegateAdd?.addToFavorite(officeResult: self.ViewModel!)
        }else {
            favoriteImage.image = UIImage(named: "favoriteNoneClicked")
            heartBtnIsTapped = true
            delegateRemove?.removeAtFavorites(favoriteId: officeId ?? 0)
        }

    }
    
    func config(viewModel: Offices.Fetch.ViewModel.Office) {
        self.ViewModel = viewModel
        officeId = Int(viewModel.id ?? "")
        adressLabel.text = viewModel.address
        nameLabel.text = viewModel.name
        capacityLabel.text = viewModel.capacity
        roomsLabel.text = viewModel.rooms
        spaceLabel.text = viewModel.space
        cellImage.sd_setImage(with: URL(string: viewModel.image ?? ""))
        
    }
    
    func setupUI(){
        contentsView.layer.cornerRadius = 18
        contentsView.layer.masksToBounds = false
        contentsView.layer.shadowColor = UIColor.black.cgColor
        contentsView.layer.shadowOpacity = 0.2
        contentsView.layer.shadowOffset = .zero
        contentsView.layer.shadowRadius = 3
        favoriteImage.image = UIImage(named: "favoriteNoneClicked")

    }
    
}
