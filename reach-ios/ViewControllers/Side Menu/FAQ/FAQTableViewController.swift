//
//  FAQTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/5/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct FAQItem : Codable {
    let question, answer : String
}

class FAQTableViewController: UITableViewController {

    var dataSource = GenericTableDataSource<FAQCell, FAQItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        let faqList = Resource<[FAQItem]>(get: URL(string:NetworkingConstants.faqs)!)
        
        URLSession.shared.load(faqList) { (faqItems, status) in
            self.dataSource.data = faqItems ?? []
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 
        let attributedString = dataSource.data[indexPath.row].answer.convertHTMLToString(withFormatting: String.formatHTML(size: 14.0))
        
        return attributedString.height(withConstrainedWidth: self.tableView.frame.size.width - 16) + 54
    }
}
