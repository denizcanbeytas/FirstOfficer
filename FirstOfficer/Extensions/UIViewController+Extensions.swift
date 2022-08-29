//
//  UIViewController+Extensions.swift
//  FirstOfficer
//
//  Created by Deniz on 29.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: Keyboard Configurations
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
