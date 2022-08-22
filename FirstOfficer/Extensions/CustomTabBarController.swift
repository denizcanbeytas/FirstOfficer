//
//  CustomTabBarController.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    @IBInspectable var initialIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // every choose we got that index
        selectedIndex = initialIndex
        // we give anything index that we want that want to start
        ChangeRadiusOfTabbar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.SimpleAnnimationWhenSelectItem(item)
    }
    
    override func viewDidLayoutSubviews() {
       self.ChangeHeightOfTabbar()
    }
    
}

extension CustomTabBarController {
    func ChangeRadiusOfTabbar(){
        
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 30
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.backgroundColor = UIColor(named: "tabBarColor")
    }
    
    func ChangeHeightOfTabbar(){
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame            = tabBar.frame
            tabFrame.size.height    = 100
            tabFrame.origin.y       = view.frame.size.height - 100
            tabBar.frame            = tabFrame
        }
    
    }
    
    // Jump Effect
    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.4
        
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
        barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
            
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}
