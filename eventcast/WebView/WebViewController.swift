//
//  WebViewController.swift
//  eventcast
//
//  Created by apple on 04/01/18.
//  Copyright © 2018 jTechAppz. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,AppNavigationControllerDelegate, UIWebViewDelegate {
    @IBOutlet var webViewAll: UIWebView!
    @IBOutlet var imageBackground: UIImageView!
    
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate let _VKAlertActionView = VKAlertActionView()
    
    internal var url: String!
    internal var page_type: K_SIDE_MENU!
    var refController:UIRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        refController.attributedTitle = NSAttributedString(string:"Pull to refresh", attributes: [
            NSAttributedStringKey.foregroundColor: COLOUR_NAV])
        refController.tintColor = COLOUR_NAV
        refController.addTarget(self, action: #selector(ForceRefresh), for: UIControlEvents.valueChanged)
        webViewAll.scrollView.addSubview(refController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageBackground.isHidden = true
        webViewAll.isHidden = false
        self.webViewShow()
    }
    
    
//MARK: APPNAVIGATION CONTROLLER DELEGATE
    fileprivate func setNavigationBar() {
        obj_AppDelegate.navigationController.setCustomTitle("EventCast")
        obj_AppDelegate.navigationController.setSideMenu()
        obj_AppDelegate.navigationController.navigationDelegate = self
        obj_AppDelegate.navigationController.setRightBackButton()
    }
    
//MARK: APPNAVIGATION CONTROLLER BUTTON
    func appNavigationController_SideMenuAction() {
        let _MKSideMenu = MKSideMenu()
        self.navigationController?.view.addSubview(_MKSideMenu)
    }
    func appNavigationController_RightBackAction() {
        if (webViewAll.canGoBack == false){
            let homeVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(homeVc, animated: false)
        }else {
            webViewAll.goBack()
        }
    }
//MARK: CUSTOME METHOD
    func webViewShow(){
        if obj_AppDelegate.isConnectedToNetwork(){
            switch page_type {
            case .k_SIDE_MENU_INFO_CCENTER:
                let baseURL : String = JWebParent_URL + JWebChild_InfoCenter_URL
                let MyURL = URL.init(string: baseURL)
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_AGENDA:
                let baseURL : String = JWebParent_URL + JWebChild_Agenda_URL + DataModel.getFingerprint()
                let agendaUrl :String = baseURL
                print(agendaUrl)
                let MyURL = URL.init(string: agendaUrl)
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_SPEAKER:
                let baseURL : String = JWebParent_URL + JWebChild_Speaker_URL
                let MyURL = URL.init(string: baseURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_PROFILE:
                print("k_SIDE_MENU_PROFILE")
            case .k_SIDE_MENU_GALLERY:
                let baseURL : String = JWebParent_URL + JWebChild_Gallery_URL + DataModel.getFingerprint()
                let galeryURL : String = baseURL
                let MyURL = URL.init(string: galeryURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_SURVEYS:
                let baseURL : String = JWebParent_URL + JWebChild_Survey_URL + DataModel.getFingerprint()
                let surveyURL : String = baseURL
                let MyURL = URL.init(string: surveyURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_PARTICIPANTS:
                 let baseURL : String = JWebParent_URL + JWebChild_Participents_URL
                let MyURL = URL.init(string: baseURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_POLLS:
                let baseURL : String = JWebParent_URL + JWebChild_Polls_URL + DataModel.getFingerprint()
                let pollsURL : String = baseURL
                print(pollsURL)
                let MyURL = URL.init(string: pollsURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_DOWNLOAD_CENTER:
                let baseURL : String = JWebParent_URL + JWebChild_Download_URL + DataModel.getFingerprint()
                let downloadURL : String = baseURL
                print(downloadURL)
                let MyURL = URL.init(string: downloadURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_LOGOUT:
                let loginVc = LoginViewController(nibName: "LoginViewController",bundle:nil)
                DataModel.setIsLaunchFirstTime("0")
                self.navigationController?.pushViewController(loginVc, animated: true)
            case .none:
                break
            case .some(_):
                break
            }
        }else{
            self._VKAlertActionView.showOkAlertView(MSG_NO_INTERNET, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            imageBackground.isHidden = false
            webViewAll.isHidden = true
        }
        
    }
    @objc func ForceRefresh(sender:AnyObject)
    {
        webViewAll.reload()
        refController.endRefreshing()
//        func ForceRefresh(refresh:UIRefreshControl)
    }
//MARK: WEBVIEW DELEGATE
    func webViewDidStartLoad(_ webView: UIWebView) {
        DesignModel.startActivityIndicator(self.view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
     DesignModel.stopActivityIndicator()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let stError: String = error as! String;
        self._VKAlertActionView.showOkAlertView(stError, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
    }

}
