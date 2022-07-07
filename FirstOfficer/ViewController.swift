//
//  ViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 5.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mainUrl = Bundle.main.infoDictionary?["BACKEND_URL"] as? String
        print(mainUrl)
        
        let showVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if showVersion {
            // TODO: show version label
        } else {
            // hide
        }


    }

}
