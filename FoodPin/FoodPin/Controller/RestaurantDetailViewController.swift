//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by 공명진 on 2018. 4. 16..
//  Copyright © 2018년 mjkong. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: RestaurantDetailHeaderView!
    
    var restaurantInformation: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }

        headerView.headerImageView.image = UIImage.init(named: (restaurantInformation?.image)!)
        headerView.nameLabel.text = restaurantInformation?.name
        headerView.typeLabel.text = restaurantInformation?.type
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
