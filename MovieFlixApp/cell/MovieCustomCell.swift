//
//  MovieCustomCell.swift
//  MovieFlixApp
//
//  Created by Apple on 10/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

protocol DataCollectionProtocol {
    func deleteData(indx:Int)
}

class MovieCustomCell: UICollectionViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var delegate: DataCollectionProtocol?
    var index:IndexPath?
    
    
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    
    @IBAction func actionOnDeleteBtn(_ sender: Any) {
        
        delegate?.deleteData(indx: index!.row)
    }
    
}
