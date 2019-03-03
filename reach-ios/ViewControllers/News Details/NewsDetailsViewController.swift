//
//  NewsDetailsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/2/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SVProgressHUD

struct NewsDetail : Codable {
    var id : Int
    var image, name, description : String
    var date : Double
}

//"id": 5,
//"image": "http://reach.xtnd.io/cms/www/images/news/xps-13-xps-15-2in1-920x6132019-01-28-02-21-55.jpg",
//"name": "LEARN MORE ABOUT DELL PRODUCTS",
//"description": "<p><a title=\"EXPLORE ALL THE PRODUCT\" href=\"https://www.dell.com/en-us\">EXPLORE ALL DELL PRODUCTS</a></p>"
//"date": 1548633600,


class NewsDetailsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Properties
    
    var newsItemID : Int?
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let newsID = newsItemID {
         
            let idString = String(describing:newsID)
            let newsDetails = Resource<NewsDetail>(get: URL(string:NetworkingConstants.newsDetails+"\(idString)")!)
            
            print(NetworkingConstants.newsDetails+"\(idString)")
            
            URLSession.shared.load(newsDetails) { (newsItem, status) in

                self.imageView.urlSetImage(newsItem?.image, #imageLiteral(resourceName: "LoginLogo"))
                self.titleLabel.text = newsItem?.name
//                self.dateLabel.text = Date(timeIntervalSince1970: (newsItem?.date)!).toString(withFormat: .DateFull)
//                print(newsItem?.description.convertHTMLToString())
                self.textView.attributedText = newsItem?.description.convertHTMLToString()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
