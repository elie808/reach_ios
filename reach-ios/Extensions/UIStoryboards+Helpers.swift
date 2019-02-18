//
//  UIStoryboards+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

public enum StoryboardIdentifier: String {
    case Main = "Main"
}

public enum ViewControllerStoryboardIdentifier: String {
    case Checkin = "CheckinViewController"
}

extension UIStoryboard {
    
    class var Main: UIStoryboard {
        struct Static {
            static let instance: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.Main.rawValue, bundle: nil)
        }
        return Static.instance
    }
}

struct Segue {
    
    struct Checkin {
        static let toQRScannerVC = "CheckinToQRScannerVC"
        static let toDuplicatesVC = "CheckinToDuplicatesVC"
        static let toGroupCheckinVC = "CheckinToGroupCheckinVC"
        static let toSpecialGroupCheckinVC = "CheckinToSpecialGroupCheckinVC"
        static let toParticipantCheckinVC = "CheckinToParticipantCheckinVC"
    }
    
    enum zabre : String {
        case toShi = "Bla"
    }
}
