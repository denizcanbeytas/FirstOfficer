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
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSlideContent()
        //setupPageControl()
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
            // for, when btn is tapped its understand in which indexPath
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // for pageControl understand to scroll and change pageControll
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}


extension OnBoardingViewController {
    func setupSlideContent(){
        slides = [
            .init(titleHead: "Find The Most Suitable Office", titleChild: "Find the office that suits you best and start working comfortably.", animationName: "findOffice", btnColor: UIColor(named: "OnBoardingSkipBtn")!, btnTitle: "Skip"),
            .init(titleHead: "Office Details", titleChild: "Select the most suitable office for you by viewing the details of the offices.", animationName: "find", btnColor: UIColor(named: "OnBoardingSkipBtn")!, btnTitle: "Skip"),
            .init(titleHead: "Map View", titleChild: "Get an easier use by displaying the locations of the offices on the map.", animationName: "map", btnColor: UIColor(named: "OnBoardingGoBtn")!, btnTitle: "Go!")
        ]
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
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationController")
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
}
