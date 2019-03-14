//
//  PersonalInfoTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/23/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class PersonalInfoTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var companyTextField : SkyFloatingLabelTextField!
    @IBOutlet weak var TCButton : UIButton!

    // MARK: - Properties

    var selectedOrganization : Organization?
    var acceptedTC : Bool = false
    
    // MARK: - Views Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTCButtonState()
    }

    // MARK: - Helpers
    
    fileprivate func setTCButtonState() {
        
        if acceptedTC == false {
            TCButton.setBackgroundImage(UIImage(named: "SurveySelectRadio"), for: .normal)
        } else {
            TCButton.setBackgroundImage(UIImage(named: "SurveySelectedRadio"), for: .normal)
        }
    }
    
    func formValid() -> Bool {
        return true
    }
    
    // MARK: - Actions

    @IBAction func didTapAcceptTerms(_ sender: UITapGestureRecognizer) {
        acceptedTC = !acceptedTC
        setTCButtonState()
    }
    
    // MARK: - Navigation

    @IBAction func unwindToPersonalInfoVC(segue : UIStoryboardSegue) {
        companyTextField.text = selectedOrganization?.name
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
