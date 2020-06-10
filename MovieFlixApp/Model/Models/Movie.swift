
//  Created by Apple on 09/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation


/// Model for objet Movie or Tv Show containes all info to show in list or details
struct movieObject: CreateFromArray{
    
    let backdrop_path : String
    
    let overview  : String
    let original_title:String
    let title:String
    
    
    /// Release date
    let release_date    : String
    /// Image for poster portrait
    let poster_path     : String
    /// Image for landscape
    
    
    
    ///Receive parameters for initializer the struct from api, is called from init JSON
    init(title:String,original_title:String,overview:String,release_date:String,poster_path:String,backdrop_path:String){
        //        self.id            = id
        self.title         = title
        
        self.overview      = overview
        self.release_date  = release_date
        self.poster_path   = poster_path
        
        self.original_title = original_title
        self.backdrop_path = backdrop_path
        
        //        self.backdrop_path = backdrop_path
        //        self.genres        = genres
        //        self.name          = name
        //        self.media_type    = media_type
        //        self.first_air_date = first_air_date
    }
    
    /**
     This init receive and validate data from Json, return nil in case the struct not is available, if all data is true  call super init fof the struct
     - Parameter json : Data from Api Rest
     */
    init?(json: JsonDictionay) {
        //        guard let id            = json["popularity"] as? Int else { return nil }
        // guard let vote_average  = json["vote_average"] as? Float else { return nil }
        let overview            = json["overview"] as? String ?? ""
        let title               = json["title"] as? String  ?? ""
        let original_title       = json["original_title"] as? String  ?? ""
        //  let original_language   = json["original_language"] as? String  ?? ""
        //        let name                = json["original_title"] as? String  ?? ""
        let release_date        = json["release_date"] as? String ?? ""
        let poster_path         = json["poster_path"] as? String ?? ""
        let backdrop_path       = json["backdrop_path"] as? String ?? ""
        //        let genres              = json["genre_ids"] as? [Int] ?? []
        //        let media_type          = json["original_title"] as? String ?? ""
        //        let first_air_date      = json["original_language"] as? String ?? ""
        
        self.init(title:title,original_title:original_title,overview:overview,release_date:release_date,poster_path:poster_path,backdrop_path:backdrop_path)
    }
}
