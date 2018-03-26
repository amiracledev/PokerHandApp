    //
    //  MainViewController.swift
    //  FiveSixTwoChallenge
    //
    //  Created by Amir Nickroo on 3/25/18.
    //  Copyright © 2018 amiracledev. All rights reserved.
    //
    
    import UIKit
    import SDWebImage

    class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
        @IBOutlet weak var collectionView: UICollectionView!
        @IBOutlet weak var showHandButtonOutlet: UIBarButtonItem!
        
        @IBOutlet var viewModel: ViewModel!
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        var cardImgLink = String()
        var cardSuitCode = "String()"
        var codeMain = ""
        var valueMain = ""
        var suit = ""
        var cardsInHand = Int()
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.delegate = self
            collectionView.dataSource = self
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            viewModel.getCards {
                self.collectionView.reloadData()
            
            }
            viewModel.getHand {
                print(self.viewModel.cardsInHand(), "Cards in hand")
                self.cardsInHand = self.viewModel.cardsInHand()
            }
            
            
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            viewModel.getHand {
                print(self.viewModel.cardsInHand(), "Cards in hand")
                print(self.cardsInHand, " Cards count")
                self.cardsInHand = self.viewModel.cardsInHand()
                self.title = "\(self.cardsInHand) Cards in hand"
                if self.cardsInHand > 0 {
                    self.showHandButtonOutlet.isEnabled = true
                } else {
                    self.showHandButtonOutlet.isEnabled = false
                }
            }
        }
        @IBAction func showHand(_ sender: Any) {
            print("right bar button tapped")
            viewModel.getHand {
                print(self.viewModel.cardsInHand(), "Cards in hand")
            }
            activityIndicator.startAnimating()
            
        }
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(true)
            activityIndicator.stopAnimating()
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfItemsToDisplay(in: section)
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
            cell.cardLabel.text = viewModel.cardLabelToDisplay(for: indexPath)
            
            let cardInfo = viewModel.imageDisplay(for: indexPath)
            
            let photoUrl = URL(string: cardInfo)
            cell.imageCard.sd_setImage(with: photoUrl)
            self.cardSuitCode = viewModel.cardCodeforDrawing(for: indexPath)
            self.cardImgLink = cardInfo
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if self.cardsInHand >= 5 {
               SetUpAlert()
            } else {
                let tag = viewModel.imageDisplay(for: indexPath)
                self.cardImgLink = tag
                self.suit = viewModel.cardLabelToDisplay(for: indexPath)
                self.codeMain = viewModel.cardCodeforDrawing(for: indexPath)
                self.valueMain = viewModel.cardValueforDrawing(for: indexPath)
                activityIndicator.startAnimating()
                performSegue(withIdentifier: "CardCell", sender: nil)
            }
            
        }
        func SetUpAlert() {
        let alert = UIAlertController(title: "🚫 Slow down buddy! 🚫", message: "This is 5 card Draw not Uno! 😁", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "CardCell" {
                let detailVC = segue.destination as! DetailViewController
                detailVC.value = self.valueMain
                detailVC.code = self.codeMain
                detailVC.imgLink = self.cardImgLink
                detailVC.suit = self.suit
            }
            
            if segue.identifier == "showHand" {
                let detailVC = segue.destination as! PlayerHandViewController
                detailVC.navigationItem.title = "My Hand"
            }
            
        }
        
    }
    
    
