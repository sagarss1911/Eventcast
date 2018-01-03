//
//  HomeViewController.swift
//  eventcast
//
//  Created by apple on 31/12/17.
//  Copyright © 2017 jTechAppz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AppNavigationControllerDelegate {
    
    fileprivate let arr = [typeAliasDictionary]()
    fileprivate let arr1 = [[String: AnyObject]]()
    
    fileprivate let dict = typeAliasDictionary()
    internal let dict1 = [String: AnyObject]()
    
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
    }
    
    //MARK: APPNAVIGATION CONTROLLER DELEGATE
    fileprivate func setNavigationBar() {
        obj_AppDelegate.navigationController.setCustomTitle("Home")
        obj_AppDelegate.navigationController.setSideMenu()
        obj_AppDelegate.navigationController.navigationDelegate = self
    }
    
    func appNavigationController_SideMenuAction() {
        let _MKSideMenu = MKSideMenu()
        self.navigationController?.view.addSubview(_MKSideMenu)
    }
    
    func mahesh(_ st: String, st1: String, b: Bool, a: [typeAliasDictionary]) -> [typeAliasDictionary] {
        let arrReturn = [typeAliasDictionary]()

        return arrReturn
    }
    


}
