//
//  UIStoryboards+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

// MARK: - Storyboard and XIB Identifiers

public enum StoryboardIdentifier: String {
    case Main = "Main"
    case SideMenu = "SideMenu"
}

public enum ViewIdentifier: String {
    case TermsAndConditions = "TAndCVC"
    case FAQs = "FaqVC"
    case Help = "HelpVC"
    case About = "AboutVC"
    case Contact = "ContactVC"
    case Settings = "SettingsVC"
}

// MARK: - Segue Identifiers

struct Segue {

    struct BrandFeedback {
        static let toFeedbackForm = "BrandFeedbackToFeedbackFormVC"
    }
    
    struct NewsList {
        static let toNewsDetails = "NewsListToNewsDetailsVC"
    }
    
    struct ProductList {
        static let toReportSale = "ProductListToReportSaleVC"
    }
    
    struct PromotionsList {
        static let toPromotionPDF = "PromotionsListToPromotionPDFVC"
    }
    
    struct ReportSale {
        static let toQRScannerVC = "ReportSaleToQRScannerVC"
        static let toDailyReport = "ReportSaleToDailyReport"
        static let toProductList = "ReportSaleToProductList"
    }
    
    struct Settings {
        static let toLoginVC = "SettingsToLoginVC"
    }
    
    struct TrainingList {
        static let toTrainingByCategory = "TrainingListToTrainingByCategoryVC"
    }

    struct TrainingCategory {
        static let toPDF = "TrainingByCategoryToPDF"
        static let toVideo = "TrainingByCategoryToVideo"
    }
    
    struct QRScanner {
        static let toReportSale = "QRScannerToReportSaleVC"
    }
}

// MARK: - Storyboard Helpers

extension UIStoryboard {
    
    class var Main: UIStoryboard {
        struct Static {
            static let instance: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.Main.rawValue, bundle: nil)
        }
        return Static.instance
    }
    
    class var SideMenu: UIStoryboard? {
        struct Static {
            static let instance: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.SideMenu.rawValue, bundle: nil)
        }
        return Static.instance
    }
}

extension UIViewController {
    
    /// Instantiates and returns an UIViewController from a Storyboard
    func instantiate<T: UIViewController>(viewControllerID:String, storyBoard: UIStoryboard?, type: T.Type ) -> T {
        
        guard let viewController = storyBoard?.instantiateViewController(withIdentifier: viewControllerID) as? T else {
            fatalError("Cannot instantiate the controller.")
        }
        
        return viewController
    }
    
}
