//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by 공명진 on 2018. 4. 19..
//  Copyright © 2018년 mjkong. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
