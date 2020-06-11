//
//  AppConstants.swift
//  MVVM-Movies


import Foundation
import UIKit

struct AppConstants {
    
    //  https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed
    
    static let protocolo    : String = "https://"
    static let apiVersion   : String = "/3"
    static let domain       : String = "api.themoviedb.org"
    static let domainImage  : String = "https://image.tmdb.org/t/p/"
    static let apiKey       : String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let keyPath      : String = "api_key="
    static let baseUrl      : String = AppConstants.protocolo + AppConstants.domain + AppConstants.apiVersion
    
    

    struct TabBarItems {
        
        struct  Movies {
            static let name =  "MoviesViewController"
            static let imageEnbled = "MoviesEnabled"
            static let imageDisabled = "MoviesDisabled"
        }
        
        
    }
    
    struct Movies {
        static let numberOfSections = 1
        static let section = 0
        static let numberOfRows = 3
        static let popularRow = 0
        static let topRateRow = 1
        static let upcomingRow = 2
        static let heightForRow = 270.0
    }
    
    struct ViewControllerIdentifier {
        
       
        static let MOVIEDETAILCONTROLLER = "movieDetailViewControllerID"
        
    }
    
    struct BaseColor {
        
       static let yellowColor = UIColor(red: 247.0/255, green: 177.0/255, blue: 88.0/255, alpha: 1.0)
        
    }
}
