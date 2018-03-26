//
//  PlayerHandViewController.swift
//  FiveSixTwoChallenge
//
//  Created by Amir Nickroo on 3/25/18.
//  Copyright © 2018 amiracledev. All rights reserved.
//

import UIKit
import SDWebImage

class PlayerHandViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var viewModel: ViewModel!
    @IBOutlet weak var tableView: UITableView!
    var code = ""
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        // Do any additional setup after loading the view.
        viewModel.getHand {
            self.tableView.reloadData()
        }
        
    }
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        activityIndicator.stopAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsToDisplayInHand(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "handCell") as! PlayerHandTableViewCell
        let value = viewModel.cardValueforDrawingInHand(for: indexPath) + " of " + viewModel.cardLabelToDisplayInHand(for: indexPath)
        cell.cardSuitValueLabel.text = value
        let handImg = viewModel.imageDisplayInHand(for: indexPath)
        let photoUrl = URL(string: handImg)
        cell.cardImage.sd_setImage(with: photoUrl)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        code = viewModel.cardCodeforDrawingInHand(for: indexPath)
        SetUpAlert(id: code)
        
    }
    func SetUpAlert(id: String) {
        let alert = UIAlertController(title: "Do you want to remove this card?", message: "", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Confirm", style: .default) { (action) in
            self.viewModel.apiClient.removeCard(id: id)
            self.activityIndicator.startAnimating()
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
