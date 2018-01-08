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
    internal var url: String!
        internal var page_type: K_SIDE_MENU!
        fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        fileprivate let _VKAlertActionView = VKAlertActionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setNavigationBar()
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
    func appNavigationController_SideMenuAction() {
        let _MKSideMenu = MKSideMenu()
        self.navigationController?.view.addSubview(_MKSideMenu)
    }
    func appNavigationController_RightBackAction() {
       // self.navigationController?.popViewController(animated: true)
        let homeVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(homeVc, animated: false)
    }
    func webViewShow(){
        if obj_AppDelegate.isConnectedToNetwork(){
            switch page_type {
            case .k_SIDE_MENU_INFO_CCENTER:
                let MyURL = URL.init(string: INFOCENTER_URL)
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_AGENDA:
                let agendaUrl :String = AGENDA_URL + DataModel.getFingerprint()
                print(agendaUrl)
                let MyURL = URL.init(string: agendaUrl)
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_SPEAKER:
                let MyURL = URL.init(string: SPEAKER_URL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_PROFILE:
                print("k_SIDE_MENU_PROFILE")
            case .k_SIDE_MENU_GALLERY:
                let galeryURL : String = GALLERY_URL + DataModel.getFingerprint()
                print(galeryURL)
                let MyURL = URL.init(string: galeryURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_SURVEYS:
                let surveyURL : String = SURVEY_URL + DataModel.getFingerprint()
                print(surveyURL)
                let MyURL = URL.init(string: surveyURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_PARTICIPANTS:
                let MyURL = URL.init(string: PARTICIPENTS_URL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_POLLS:
                let pollsURL : String = POLLS_URL + DataModel.getFingerprint()
                print(pollsURL)
                let MyURL = URL.init(string: pollsURL )
                let request = URLRequest(url:MyURL!)
                webViewAll.loadRequest(request)
            case .k_SIDE_MENU_DOWNLOAD_CENTER:
                let downloadURL : String = DOWNLOAD_URL + DataModel.getFingerprint()
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
