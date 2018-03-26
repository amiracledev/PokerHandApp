//
//  ViewModel.swift
//  FiveSixTwoChallenge
//
//  Created by Amir Nickroo on 3/25/18.
//  Copyright © 2018 amiracledev. All rights reserved.
//

import UIKit
import CoreData

class ViewModel: NSObject {
    @IBOutlet var apiClient: APIClient!
    
   
    var hand: [NSDictionary]?
    var cards: [NSDictionary]?
    var items: [NSManagedObject] = []
    func getCards(completion: @escaping() -> Void) {
        
        apiClient.fetchCard(completion: ({ (arrayOfCardsDict) in
            DispatchQueue.main.async {
                self.cards = arrayOfCardsDict
                completion()
            }
        }))
    }
    
    
    func drawCard(id: String) {
        apiClient.drawCard(id: id)
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return cards?.count ?? 0
    }
    func cardValueforDrawing(for indexPath: IndexPath) -> String {
        return cards?[indexPath.row].value(forKeyPath: "value") as? String ?? ""
    }
    func cardCodeforDrawing(for indexPath: IndexPath) -> String {
        return cards?[indexPath.row].value(forKeyPath: "code") as? String ?? ""
    }
    func cardLabelToDisplay(for indexPath: IndexPath) -> String {
        return cards?[indexPath.row].value(forKeyPath: "suit") as? String ?? ""
    }
    
    func imageDisplay(for indexPath: IndexPath) -> String {
        return cards?[indexPath.row].value(forKeyPath: "image") as? String ?? ""
    }
    //Showing Hand
    func getHand(completion: @escaping() -> Void) {
        
        apiClient.fetchHand(completion: ({ (arrayOfHandDict) in
            DispatchQueue.main.async {
                self.hand = arrayOfHandDict
                completion()
            }
        }))
    }
    func cardsInHand() -> Int {
        return hand?.count ?? 0
    }
    func numberOfItemsToDisplayInHand(in section: Int) -> Int {
        return hand?.count ?? 0
    }
    func imageDisplayInHand(for indexPath: IndexPath) -> String {
        return hand?[indexPath.row].value(forKeyPath: "image") as? String ?? ""
    }
    func cardValueforDrawingInHand(for indexPath: IndexPath) -> String {
        return hand?[indexPath.row].value(forKeyPath: "value") as? String ?? ""
    }
    func cardCodeforDrawingInHand(for indexPath: IndexPath) -> String {
        return hand?[indexPath.row].value(forKeyPath: "code") as? String ?? ""
    }
    func cardLabelToDisplayInHand(for indexPath: IndexPath) -> String {
        return hand?[indexPath.row].value(forKeyPath: "suit") as? String ?? ""
    }
    
    
}
