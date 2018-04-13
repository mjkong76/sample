//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by 공명진 on 2018. 4. 8..
//  Copyright © 2018년 mjkong. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    let restaurants = DummyRestaurant().restaurants
    var dictionary: [Int: IndexPath] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RestaurantTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantTableCell", for: indexPath) as! RestaurantTableViewCell

        cell.food.image = UIImage.init(named: restaurants[indexPath.item].image)!
        cell.name.text = restaurants[indexPath.item].name
        cell.location.text = restaurants[indexPath.item].location
        cell.type.text = restaurants[indexPath.item].type
        cell.heart.isHidden = restaurants[indexPath.row].isVisited ? false : true
        cell.more.tag = indexPath.row
        dictionary[indexPath.row] = indexPath
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func moreAction(_ sender: Any) {
        let button = sender as! UIButton
        
        // create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .alert)
        
        // add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // add call action
        optionMenu.addAction(UIAlertAction(
            title: "Call" + "123-000-\(button.tag)",
            style: .default,
            handler: { (action: UIAlertAction!) in
                // behavior implement
                let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
        }))
        
        // add checkin action
        var alertTitle = "Check in"
        if self.restaurants[button.tag].isVisited {
            alertTitle = "Undo Check in"
        }
        optionMenu.addAction(UIAlertAction(
            title: alertTitle,
            style: .default,
            handler: { (action: UIAlertAction!) in
                // behavior implement
                let cell = self.tableView.cellForRow(at: self.dictionary[button.tag]!) as! RestaurantTableViewCell
                if self.restaurants[button.tag].isVisited {
                    self.restaurants[button.tag].isVisited = false
                    cell.heart.isHidden = true
                } else {
                    self.restaurants[button.tag].isVisited = true
                    cell.heart.isHidden = false
                }
        }))
        
        // add delete action
        optionMenu.addAction(UIAlertAction(
            title: "Delete",
            style: .default,
            handler: { (action: UIAlertAction) in
        }))
        
        // add share action
        optionMenu.addAction(UIAlertAction(
            title: "Share",
            style: .default,
            handler: { (action: UIAlertAction) in
                let defaultText = "Just checking in at " + self.restaurants[button.tag].name
                if let image = UIImage.init(named: self.restaurants[button.tag].image) {
                    let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                } else {
                    let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                }
        }))
        
        // display menu
        present(optionMenu, animated: true, completion: nil)
    }
}
