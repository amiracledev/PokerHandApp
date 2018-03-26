//
//  DetailViewController.swift
//  FiveSixTwoChallenge
//
//  Created by Amir Nickroo on 3/25/18.
//  Copyright © 2018 amiracledev. All rights reserved.
//

import UIKit
import SDWebImage
import ProgressHUD
class DetailViewController: UIViewController {
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet var apiClient: APIClient!
    @IBOutlet weak var imageView: UIImageView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var code = ""
    var suit = ""
    var value = ""
    var imgLink = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = value + " of " + suit
        let photoUrl = URL(string: imgLink)
        imageView.sd_setImage(with: photoUrl)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        activityIndicator.stopAnimating()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        //pass data into method to draw a hand
        print(code, "Printing card code to pass in to core data")
        apiClient.drawCard(id: code)
        activityIndicator.startAnimating()
        ProgressHUD.showSuccess("Nice Choice!")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
