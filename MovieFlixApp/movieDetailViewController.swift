//
//  movieDetailViewController.swift
//  MovieFlixApp
//
//  Created by Apple on 10/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class movieDetailViewController: UIViewController {

    var detailString = ""
    var dateString = ""
    var ratingString = ""
    var titleString = ""
    var finalImage = UIImage()


    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

          self.navigationController?.isNavigationBarHidden = false
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = titleString
        detailLabel.text = detailString
        dateLabel.text = dateString
        backImage.image = finalImage
        // Do any additional setup after loading the view.
        
//        detailLabel.lineBreakMode = .byWordWrapping //in versions below swift 3 (messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping)
//        detailLabel.numberOfLines = 0 //To write any number of lines within a label scope
//        
//        detailLabel.textAlignment = .left
//        detailLabel.sizeToFit()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
         self.navigationController?.isNavigationBarHidden = true
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
