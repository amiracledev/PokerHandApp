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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        viewModel.getHand {
        self.tableView.reloadData()
        }
        
    }
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        print(indexPath)
//        
//        return
//    }
    
    
}
