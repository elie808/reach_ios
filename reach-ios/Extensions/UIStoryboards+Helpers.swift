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

//public enum ViewControllerStoryboardIdentifier: String {
//    case ReportSale = "ReportSaleViewController"
//}

extension UIStoryboard {
    
    class var Main: UIStoryboard {
        struct Static {
            static let instance: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.Main.rawValue, bundle: nil)
        }
        return Static.instance
    }
}

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
