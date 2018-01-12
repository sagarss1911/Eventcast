//
//  HomeViewController.swift
//  eventcast
//
//  Created by apple on 31/12/17.
//  Copyright © 2017 jTechAppz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AppNavigationControllerDelegate {
    
   
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblWelcome: UILabel!
    fileprivate let arr = [typeAliasDictionary]()
    fileprivate let arr1 = [[String: AnyObject]]()
    
    fileprivate let dict = typeAliasDictionary()
    internal let dict1 = [String: AnyObject]()
    
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate let obj_OperationWeb = OperationWeb()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblWelcome.text = "Welcome \(DataModel.getUsername())"
        self.lblDescription.numberOfLines = 0
        self.lblDescription.text = DataModel.getHomeDetail()["welcome"] as? String
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
    }
    
    
    //MARK: APPNAVIGATION CONTROLLER DELEGATE
    fileprivate func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    @IBAction func btnInfoCenterAction(_ sender: UIButton) {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_INFO_CCENTER
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
    @IBAction func btnAgendaAction(_ sender: UIButton) {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_AGENDA
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
    @IBAction func bntSurveyAction(_ sender: UIButton) {
      let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_SURVEYS
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
    @IBAction func btnPollsAction(_ sender: UIButton) {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_POLLS
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    @IBAction func btnEventCastAction(_ sender: UIButton) {
        obj_AppDelegate.openSafari()
    }
}
