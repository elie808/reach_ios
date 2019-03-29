//
//  DatePickerView.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/28/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
    func backspaceTapped()
    func searchTapped()
}

class DatePickerView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var datePicker : UIDatePicker!
    
    // MARK: - Properties
    
    weak var delegate: KeyboardDelegate?
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "DatePickerView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    // MARK:- Actions
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        if delegate != nil {
            //            self.delegate?.keyWasTapped(character: sender.titleLabel!.text!) // could alternatively send a tag value
        }
    }
}
