//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by 공명진 on 2018. 4. 8..
//  Copyright © 2018년 mjkong. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    let restaurant = Restaurant()

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
        return restaurant.names.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RestaurantTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantTableCell", for: indexPath) as! RestaurantTableViewCell

        cell.food.image = UIImage.init(named: restaurant.images[indexPath.item])!
        cell.name.text = restaurant.names[indexPath.item]
        cell.location.text = restaurant.locations[indexPath.item]
        cell.type.text = restaurant.types[indexPath.item]
        cell.heart.isHidden = restaurant.checkin[indexPath.row] ? false : true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .alert)
        
        // add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // add call action
        optionMenu.addAction(UIAlertAction(
            title: "Call" + "123-000-\(indexPath.row)",
            style: .default,
            handler: { (action: UIAlertAction!) in
            // behavior implement
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }))
        
        // add checkin action
        var alertTitle = "Check in"
        if self.restaurant.checkin[indexPath.row] {
            alertTitle = "Undo Check in"
        }
        optionMenu.addAction(UIAlertAction(
            title: alertTitle,
            style: .default,
            handler: { (action: UIAlertAction!) in
            // behavior implement
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            if self.restaurant.checkin[indexPath.row] {
                cell.heart.isHidden = true
                self.restaurant.checkin[indexPath.row] = false
            } else {
                cell.heart.isHidden = false
                self.restaurant.checkin[indexPath.row] = true
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
                let defaultText = "Just checking in at " + self.restaurant.names[indexPath.row]
                if let image = UIImage.init(named: self.restaurant.images[indexPath.row]) {
                    let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                } else {
                    let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                }
        }))
        
        // display menu
        present(optionMenu, animated: true, completion: nil)
        
        // deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
