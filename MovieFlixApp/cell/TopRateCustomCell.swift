//
//  TopRateCustomCell.swift
//  MovieFlixApp
//
//  Created by Apple on 11/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

protocol DataCollectionProtocolForRated {
    func deleteData(indx:Int)
}
class TopRateCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    
    var delegate: DataCollectionProtocolForRated?
    var index:IndexPath?
    
    
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBAction func actionOnDeleteCell(_ sender: Any) {
        delegate?.deleteData(indx: index!.row)
    }
    
   
}
