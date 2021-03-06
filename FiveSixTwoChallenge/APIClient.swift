//
//  APIClient.swift
//  FiveSixTwoChallenge
//
//  Created by Amir Nickroo on 3/25/18.
//  Copyright © 2018 amiracledev. All rights reserved.
//

import UIKit
import CoreData
import ProgressHUD
class APIClient: NSObject {
    
    
    var newDeckID = String()
    var newID = ""
    func getDeckID () {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/") else {
            ProgressHUD.showError("Error unwrapping URL")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    if let dID = responseJSON.value(forKeyPath: "deck_id") as? String {
                   
                        self.newID = dID
                        self.saveId(id: self.newID)
                    }
                }
            } catch {
                ProgressHUD.showError(error.localizedDescription)
                
            }
        }
        dataTask.resume()
    }
    
    func saveId(id: String){
        
        DispatchQueue.main.async {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            //unwrap later
            let entity = NSEntityDescription.entity(forEntityName: "Deck", in: managedContext)!
            let item = NSManagedObject(entity: entity, insertInto: managedContext)
            item.setValue(id, forKey: "deckid")
            
            do {
                try managedContext.save()
                
            } catch let err as NSError {
                print(err, "")
                
            }
            
        }
    }
    
    func fetchCard(completion: @escaping ([NSDictionary]?) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        var currentId = ""
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Deck")
        request.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(request)
            if results.count > 0 {
                for result in (results as? [NSManagedObject])! {
                    if let deckID = result.value(forKey: "deckid") as? String {
                        currentId = deckID
                    }
                }
            }
        } catch {
            print("errors")
        }
        let dealer = "https://deckofcardsapi.com/api/deck/\(currentId)/draw/?count=52"
        
        guard let url = URL(string: dealer) else {
            print("Error unwrapping URL")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    if let allCards = responseJSON.value(forKeyPath: "cards") as? [NSDictionary] {
                        
                        completion(allCards)
                    }
                }
            } catch {
                
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    func drawCard(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        var currentId = ""
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Deck")
        request.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(request)
            if results.count > 0 {
                for result in (results as? [NSManagedObject])! {
                    if let deckID = result.value(forKey: "deckid") as? String {
                        
                        currentId = deckID
                    }
                }
            }
        } catch {
            print("errors")
        }
        let dealer = "https://deckofcardsapi.com/api/deck/\(currentId)/pile/player1/add/?cards=\(id)"
       
        guard let url = URL(string: dealer) else {
            print("Error unwrapping URL")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    if let allCards = responseJSON.value(forKeyPath: "cards") as? [NSDictionary] {
                        print(allCards, "Successfully Saved Card")
                    }
                }
            } catch {
                
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
        
    }
    
    func fetchHand(completion: @escaping ([NSDictionary]?) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        var currentId = ""
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Deck")
        request.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(request)
            if results.count > 0 {
                for result in (results as? [NSManagedObject])! {
                    if let deckID = result.value(forKey: "deckid") as? String {
                        
                        currentId = deckID
                    }
                }
            }
        } catch {
            print("errors")
        }
        let dealer = "https://deckofcardsapi.com/api/deck/\(currentId)/pile/player1/list"
        guard let url = URL(string: dealer) else {
            print("Error unwrapping URL")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    if let allCards = responseJSON.value(forKeyPath: "piles.player1.cards") as? [NSDictionary] {
                        
                        completion(allCards)
                    }
                }
            } catch {
                
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    func removeCard(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        var currentId = ""
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Deck")
        request.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(request)
            if results.count > 0 {
                for result in (results as? [NSManagedObject])! {
                    if let deckID = result.value(forKey: "deckid") as? String {
                        
                        currentId = deckID
                    }
                }
            }
        } catch {
            print("errors")
        }
        let dealer = "https://deckofcardsapi.com/api/deck/\(currentId)/pile/player1/draw/?cards=\(id)"
        guard let url = URL(string: dealer) else {
            print("Error unwrapping URL")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    if let allCards = responseJSON.value(forKeyPath: "piles.player1.cards") as? [NSDictionary] {
                        print(allCards.count)
                        ProgressHUD.showSuccess("Card removed!")
                    }
                }
            } catch {
                
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
        
    }
    
}
