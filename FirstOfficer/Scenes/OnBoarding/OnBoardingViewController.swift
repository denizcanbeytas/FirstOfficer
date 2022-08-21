//
//  OnBoardingViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnBoardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSlideContent()
        //setupPageControl()
    }
    
    private func setupCollectionView(){
        collectionView.register(UINib(nibName: "OnBoardingCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: OnBoardingCollectionViewCell.identifer)
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
    }
    
    private func handleActionBtnTapped(at indexPath:IndexPath){
        if indexPath.item == slides.count - 1 {
            // we are on the last slide
            showWelcomePage()
        }else {
            let nextItem = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
            pageControl.currentPage = nextItem
        }
    }
    
    private func showWelcomePage(){
        let welcomePageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationController")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = welcomePageVC
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifer, for: indexPath) as? OnBoardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let slide = slides[indexPath.row]
        cell.configureCell(slide)
        cell.btnActionTap = {[weak self] in
            self?.handleActionBtnTapped(at: indexPath)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}


extension OnBoardingViewController {
    func setupSlideContent(){
        slides = [
            .init(titleHead: "Find the most suitable office", titleChild: "Find the office that suits you best and start working comfortably", animationName: "findOffice", btnColor: .yellow, btnTitle: "Skip"),
            .init(titleHead: "Office Details", titleChild: "Select the most suitable office for you by viewing the details of the offices.", animationName: "find", btnColor: .yellow, btnTitle: "Skip"),
            .init(titleHead: "Map View", titleChild: "Get an easier use by displaying the locations of the offices on the map.", animationName: "map", btnColor: .green, btnTitle: "Go!")
        ]
    }
    
}
