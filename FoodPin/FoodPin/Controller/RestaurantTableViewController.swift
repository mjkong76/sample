//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by 공명진 on 2018. 4. 8..
//  Copyright © 2018년 mjkong. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants = DummyRestaurant().restaurants
    var dictionary: [Int: IndexPath] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        /**
         To make the navigation bar transparent,
         all you need to do is set the background image and shadow image to a blank image (i.e. UIImage())
         */
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
                let foregroundColor = UIColor(red: 231, green: 76, blue: 60)
                navigationController?.navigationBar.largeTitleTextAttributes = [
                    NSAttributedStringKey.foregroundColor: foregroundColor, NSAttributedStringKey.font: customFont
                ]
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnSwipe = true
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
                self.restaurants.remove(at: button.tag)
                self.tableView.deleteRows(at: [self.dictionary[button.tag]!], with: .fade)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurantInformation = restaurants[indexPath.row]
            }
        }
    }
}
