//
//  HelpViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/8/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct HelpItem {
    let title, description : String
    let image : UIImage
    let circleColor : UIColor
}

class HelpViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<GenericCollectionCell<HelpItem>, HelpItem>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.data = [
            HelpItem(title: "Selling can be fun ? \n We certainly think so!", description: "Engage, learn and earn with REACH through registering your sales team. Our app tunes your sales skills, and lets you earn a wide range of rewards.", image: #imageLiteral(resourceName: "Help1one"), circleColor: .reachGreen),
            HelpItem(title: "Learn", description: "Become involved with your brand community. And get everything you need to know about the product that you are selling and the brand that you represent.", image: #imageLiteral(resourceName: "TrainingHowTo"), circleColor: .reachGreen),
            HelpItem(title: "Earn", description: "Become involved with your brand community. And get everything you need to know about the product that you are selling and the brand that you represent.", image: #imageLiteral(resourceName: "MainPromotionIcon"), circleColor: .reachGreen),
            HelpItem(title: "Report Sale", description: "Earn points for the sales and training that you make. Get the change to become best sales person of the year. Make your hard work pay off. \n \n Engage, learn and earn with REACH through registering your sales team. Our app tunes your sales skills, and lets you earn a wide range of rewards.", image: #imageLiteral(resourceName: "TabReport"), circleColor: .reachOrange),
            HelpItem(title: "Send your daily report", description: "Here lies your unlocked opportunity to become part of a community of motivated sales professionals looking to perfect their craft and stay true to the values of their representative brands.", image: #imageLiteral(resourceName: "TabDailyReport"), circleColor: .reachGreen),
            HelpItem(title: "Perform", description: "Earn points for the sales and training that you make. Get the change to become best sales person of the year. Make your hard work pay off. \n \n Engage, learn and earn with REACH through registering your sales team. Our app tunes your sales skills, and lets you earn a wide range of rewards.", image: #imageLiteral(resourceName: "MainPerformanceIcon"), circleColor: .reachYellow),
            HelpItem(title: "Share", description: "Here lies your unlocked opportunity to become part of a community of motivated sales professionals looking to perfect their craft and stay true to the values of their representative brands.", image: #imageLiteral(resourceName: "MainBrandIcon"), circleColor: .reachOrange),
            HelpItem(title: "Follow news", description: "Here lies your unlocked opportunity to become part of a community of motivated sales professionals looking to perfect their craft and stay true to the values of their representative brands.", image: #imageLiteral(resourceName: "TabNews"), circleColor: .reachGreen)
        ]
        collectionView.dataSource = dataSource
    }
    
}

extension HelpViewController : UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
