//
//  PageViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import UIKit

class PageViewController: UIPageViewController {
 
    var VCList = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setupNavigationBar()
    }
}
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController == VCList.last{
            return VCList.first
        } else if viewController == VCList.first{
            return nil
        }else {return nil}
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController == VCList.first{
            return VCList.last
        } else if viewController == VCList.last{
            return nil
        }else {return nil}
    }
}

extension PageViewController {
    
    func setViewControllers(){
        super.viewDidLoad()
        let tabbarStoryboard = UIStoryboard(name: "Offices", bundle: nil)
        let tabbarController : CustomTabBarController = tabbarStoryboard.instantiateViewController(identifier: "TabbarController")
        let mapViewStoryboard = UIStoryboard(name: "MapView", bundle: nil)
        let mapViewController : MapViewViewController = mapViewStoryboard.instantiateViewController(identifier: "mapViewVC")
        VCList = [tabbarController,mapViewController]
        delegate = self
        dataSource = self
        
        if let firstVC = VCList.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    func setupNavigationBar(){
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Offices"
    }
}
