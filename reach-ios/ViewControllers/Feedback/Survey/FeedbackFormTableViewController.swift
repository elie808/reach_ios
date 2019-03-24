//
//  FeedbackFormTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

// MARK: - GET objects

struct FeedbackSurvey : Codable {
    let id, organization_id, countt : Int
    let title : String
    let questions : [Question]
//    let createdAt, updatedAt : String
}

struct Question : Codable {
    let id, feedback_survey_id : Int
    let question : String
}

// MARK: - POST objects

struct PostSurvey : Codable {
    let answers : [Answer]
    let comment : String
}

struct Answer : Codable {
    let id : Int
    let answer : String
}

// MARK: - UI objects

enum RatingValues : String {
    case excellent = "excellent"
    case veryGood = "very good"
    case good = "good"
    case fair = "fair"
    case poor = "poor"
}

struct FeedbackRating {
    var isSelected : Bool = false
    let value : String
}

class FeedbackFormTableViewController: UITableViewController {

    // MARK: - Properties
    
    var passedOrganization : Organization?
    var ratingList : [FeedbackRating] = []
    var feedbackSurvey : FeedbackSurvey?
    var comment : String = ""
    
    // MARK: - Outlets
    
    @IBOutlet weak var emptySurveyView : UIView!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputAccessoryView = toolBar
        
        ratingList = [FeedbackRating(isSelected: false, value: RatingValues.excellent.rawValue),
                      FeedbackRating(isSelected: false, value: RatingValues.veryGood.rawValue),
                      FeedbackRating(isSelected: false, value: RatingValues.good.rawValue),
                      FeedbackRating(isSelected: false, value: RatingValues.fair.rawValue),
                      FeedbackRating(isSelected: false, value: RatingValues.poor.rawValue)]
        
        let survey = Resource<FeedbackSurvey>(get: URL(string: NetworkingConstants.feedbackSurvey(forOrgID: (passedOrganization?.id)!))!)

        URLSession.shared.load(survey) { (response, status) in
            if let survey = response {
                self.feedbackSurvey = survey
                if survey.questions.count > 0 {
                    self.questionLabel.text = survey.questions.first?.question
                } else {
                    self.emptySurveyView.frame = self.tableView.frame
                    self.view.addSubview(self.emptySurveyView)
                }
            } else {
                self.emptySurveyView.frame = self.tableView.frame
                self.view.addSubview(self.emptySurveyView)
            }
        }
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
            for i in 0...ratingList.count-1 {
                ratingList[i].isSelected = false
            }
            ratingList[indexPath.row-1].isSelected = true
            
            tableView.reloadData()
            
        default: return
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        
        if let text = textView.text {
            comment = text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        textView.resignFirstResponder()
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        
        let selectedFeedback = ratingList.filter( {$0.isSelected == true} ).first

        let postObj = PostSurvey(answers: [Answer(id: (feedbackSurvey?.questions[0].id)!, answer: (selectedFeedback?.value)!)], comment: comment)
        
        let answers = Resource<PostSurvey>(url: URL(string: NetworkingConstants.postFeedbackSurvey(forSurveyID: (feedbackSurvey?.id)! ))!,
                                           method: HttpMethod<PostSurvey>.post(postObj))
        
        URLSession.shared.load(answers, completion: { (response, status) in
            if status.code == 200 {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }) { (error, status) in
            self.show(alert: "Error \(String(describing:(error?.code)!))", message: (error?.message)!, buttonTitle: "OK", onSuccess: nil)
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

extension FeedbackFormTableViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
}
