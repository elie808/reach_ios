//
//  SharpenSkillsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Skills {
    let imageName, title, date, description : String
}

class SharpenSkillsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<SharpenSkillsCell, Skills>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.data = [Skills(imageName: "dummy_pdf", title: "Cheat sheet", date: "June 16, 2018", description: "Lorem ipsum dolor sit amet, sed do eiusmod."),
        Skills(imageName: "dummy_pdf", title: "Cheat sheet", date: "June 16, 2018", description: "Lorem ipsum dolor sit amet, sed do eiusmod."),
        Skills(imageName: "dummy_pdf", title: "Cheat sheet", date: "June 16, 2018", description: "Lorem ipsum dolor sit amet, sed do eiusmod.")]
        tableView.dataSource = dataSource
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension SharpenSkillsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
