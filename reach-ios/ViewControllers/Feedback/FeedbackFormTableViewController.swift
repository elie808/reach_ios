//
//  FeedbackFormTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct FeedbackRating {
    var isSelected : Bool = false
    let value : Int
}

class FeedbackFormCell: UITableViewCell {
    @IBOutlet weak var cellAccessoryImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with feedback:FeedbackRating) {
        if feedback.isSelected == true {
            cellAccessoryImageView.backgroundColor = .white
        } else {
            cellAccessoryImageView.backgroundColor = .clear
        }
    }
}

class FeedbackFormTableViewController: UITableViewController {

    // MARK: - Properties
    
    var ratingList : [FeedbackRating] = []
    
    // MARK: - Outlets
    
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputAccessoryView = toolBar
        
        ratingList = [FeedbackRating(isSelected: false, value: 1), FeedbackRating(isSelected: false, value: 2), FeedbackRating(isSelected: false, value: 3), FeedbackRating(isSelected: false, value: 4), FeedbackRating(isSelected: false, value: 5)]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 1...5:
            let cell = super.tableView(tableView, cellForRowAt: indexPath) as! FeedbackFormCell
            cell.configure(with: ratingList[indexPath.row-1])
            return cell
            
        default: return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1...5:
            for _ in 0...ratingList.count {
                ratingList[indexPath.row-1].isSelected = false
            }
            ratingList[indexPath.row-1].isSelected = true
            
            tableView.reloadData()
            
        default: return
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        textView.resignFirstResponder()
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        
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

extension FeedbackFormTableViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("EHGGG  r")
        
    }
}
