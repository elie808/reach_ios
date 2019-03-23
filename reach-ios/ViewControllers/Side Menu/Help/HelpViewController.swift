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
            HelpItem(title: "Selling can be fun ? \nWe certainly think so!", description: "Engage, learn and earn with REACH. Our app tunes your sales skills, and lets you earn a wide range of rewards for your learning and sales, while sharing and growing the ecosystem.", image: #imageLiteral(resourceName: "Help1one"), circleColor: .reachGreen),
            
            HelpItem(title: "Learn", description: "Learning has never been so much easy and exciting. REACH provides you with smart and automated trainings about products/services and brands you sell. Go to Training when you want: \n \n • Know better Your product – find there everything about your products/services or \n \n • Sharpen your skills – this is our unique sales program that will empower you to sell more efficiently. We share with you some quick trainings. REACH provides you with the best available in the market sales training, free.", image: #imageLiteral(resourceName: "TrainingHowTo"), circleColor: .reachGreen),
            
            HelpItem(title: "Earn", description: "REACH provides you with the information about motivational programs of the brands you represent. Those promotions are created by the brands or their partners and it is designed by them. Reach facilitate the automation of managing those promos from activation to redeeming your coins or prizes.", image: #imageLiteral(resourceName: "MainPromotionIcon"), circleColor: .reachGreen),
            
            HelpItem(title: "Report sales", description: "Report sales tab is for you to report your sales and to add all the sales proof required for a specific promotion. \n \nMake sure you follow every promo instruction, as every promo/client/Vendors may have different sales proof requirements that you need to report back. \n \nA wrong sales reporting of a sale or missing information or required documents will cause a disqualification of the sale and coins will not be counted for this sale. \n \nOur system can easily detect frauds so avoid reporting something you did not sell. \n \nOnce you submit it goes into Your daily Report and to the authorized person that will approve it if all requirements are met.", image: #imageLiteral(resourceName: "TabReport"), circleColor: .reachOrange),
            
            HelpItem(title: "Daily report", description: "All reported sales are collected in your Daily report. After you have reported your sales to the app, you still can edit them in your Daily Report and then you need to submit and it will go to your authorized approval.", image: #imageLiteral(resourceName: "TabDailyReport"), circleColor: .reachGreen),
            
            HelpItem(title: "Perform", description: "REACH allows you to track your performance and earn coins. \n In the Performance tab you can see: \n\n• Your total amount of coins – your lifetime coins that you have earned since joining REACH that are not redeemed yet. \n \n• Your approved sales – sales that were approved and available for redeeming. \n \n• Pending sales – sales that you have reported but that are still in verification by the authorized approval.", image: #imageLiteral(resourceName: "MainPerformanceIcon"), circleColor: .reachYellow),
            
            HelpItem(title: "Share", description: "It is your Chance to give feedback about Product/services, client opinions, market to the brands you are selling. Your opinion is valued, don’t hesitate to answer all the questions and it might be rewarded as well.", image: #imageLiteral(resourceName: "MainBrandIcon"), circleColor: .reachOrange),
            
            HelpItem(title: "Follow news", description: "News Tab provides you with the latest news from your brands about new promotions and trainings. \n \nTrain, sell, Earn plenty of coins and have fun!", image: #imageLiteral(resourceName: "TabNews"), circleColor: .reachGreen)
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
