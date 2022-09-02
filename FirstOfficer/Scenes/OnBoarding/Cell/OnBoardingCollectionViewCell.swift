//
//  OnBoardingCollectionViewCell.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import UIKit
import Lottie

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifer = String(describing: OnBoardingCollectionViewCell.self)

    @IBOutlet weak var btnOutlet: UIButton!
    @IBOutlet weak var labelChild: UILabel!
    @IBOutlet weak var labelHead: UILabel!
    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var pageContol: UIPageControl!
    
    var btnActionTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func btnAction(_ sender: Any) {
        btnActionTap?()
    }
    
    func configureCell(_ slide: OnBoardingSlide){
        //btnOutlet.backgroundColor = UIColor(named: slide.btnColor)
        btnOutlet.backgroundColor = slide.btnColor
        btnOutlet.setTitle(slide.btnTitle, for: .normal)
        labelChild.text = slide.titleChild
        labelHead.text = slide.titleHead
        //imageView.image = UIImage(named: slide.animationName)
        
        let animation = Animation.named("\(slide.animationName)")
        lottieView.animation = animation
        lottieView.loopMode = .loop
        lottieView.animationSpeed = 0.5
        
        if (!lottieView.isAnimationPlaying){
            lottieView.play()
        }
        
    }

}
