//
//  VKAlertActionView.swift
//  BusinessCard
//
//  Created by Keyur on 05/01/18.
//  Copyright © 2018 jTechappz. All rights reserved.
//

public enum ALERT_TYPE: Int {
    case DUMMY
    case ADD_CARD
    case EDIT_CARD
    case DELETE_CARD
    case SAVE_CARD
    case SEND_CARD
    case MORE
    case VK_FOOTER_ADD
    case RETURN
    case CANCEL
    case TRACK
    case CANCEL_OFFER
}

public enum ACTION_SHEET_TYPE :Int
{
    case ACTION_SHEET_DUMMY
    case ACTION_SHEET_MORE
    case ACTION_SHEET_EMAIL
}

protocol VKAlertActionViewDelegate
{
    func vkAlertViewAction(_ alertType: ALERT_TYPE, buttonIndex: Int, buttonTitle: String, object: String)
    func vkActionSheetAction(_ actionSheetType: ACTION_SHEET_TYPE, buttonIndex: Int, buttonTitle: String, object: String)
}

import UIKit

class VKAlertActionView: NSObject {
    
    //MARK: PROPERTIES
    var delegate: VKAlertActionViewDelegate! = nil
    
    //MARK: VARIABLES
    let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate var _ALERT_TYPE: ALERT_TYPE = ALERT_TYPE.DUMMY
    fileprivate var _string: String = ""
    fileprivate var _ACTION_SHEET_TYPE: ACTION_SHEET_TYPE!
    
    
    internal func showYesNoAlertView(_ message: String, alertType: ALERT_TYPE, object: String) {
        _ALERT_TYPE = alertType
        _string = object
        let alertController = UIAlertController.init(title: MSG_TITLE, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.default) { (action) in
            self.delegate.vkAlertViewAction(self._ALERT_TYPE, buttonIndex: 0, buttonTitle: "Yes", object: self._string)
        })
        
        alertController.addAction(UIAlertAction.init(title: "No", style: UIAlertActionStyle.destructive) { (action) in
            self.delegate.vkAlertViewAction(self._ALERT_TYPE, buttonIndex: 1, buttonTitle: "No", object: self._string)
        })
        
        obj_AppDelegate.navigationController.present(alertController, animated: true, completion: nil)
    }
    
    internal func showOkAlertView(_ message: String, alertType: ALERT_TYPE, object: String, isCallDelegate: Bool) {
        _ALERT_TYPE = alertType
        _string = object
        let alertController = UIAlertController.init(title: MSG_TITLE, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (action) in
            if isCallDelegate {
                self.delegate.vkAlertViewAction(self._ALERT_TYPE, buttonIndex: 0, buttonTitle: "Ok", object: self._string)
            }
        })
        
        obj_AppDelegate.navigationController.present(alertController, animated: true, completion: nil)
    }
    
    internal func showAlertView(_ arrTitle: [String], message: String, isIncludeCancelButton : Bool, alertType: ALERT_TYPE, object: String)
    {
        var arrTitle = arrTitle
        _ALERT_TYPE = alertType
        _string = object
        
        let alertController = UIAlertController.init(title: MSG_TITLE, message: message, preferredStyle: UIAlertControllerStyle.alert)

        for i in 0..<arrTitle.count {
            alertController.addAction(UIAlertAction.init(title: arrTitle[i], style: UIAlertActionStyle.default) { (action) in
                self.delegate.vkAlertViewAction(self._ALERT_TYPE, buttonIndex: i, buttonTitle: arrTitle[i], object: self._string)
            })
        }
        
        if isIncludeCancelButton {
            alertController.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.destructive) { (action) in
                self.delegate.vkAlertViewAction(self._ALERT_TYPE, buttonIndex: arrTitle.count, buttonTitle: "Cancel", object: self._string)
            })
        }
        
        obj_AppDelegate.navigationController.present(alertController, animated: true, completion: nil)
    }
    
    internal func showActionSheet(_ arrTitle: [String], message: String, isIncludeCancelButton : Bool, actionSheetType: ACTION_SHEET_TYPE, object: String)
    {
        var arrTitle = arrTitle
        _ACTION_SHEET_TYPE = actionSheetType
        _string = object
        
        let alertController = UIAlertController.init(title: MSG_TITLE, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if isIncludeCancelButton { arrTitle.append("Cancel") }
        
        for i in 0..<arrTitle.count {
            alertController.addAction(UIAlertAction(title: arrTitle[i], style: .default, handler: {(_ action: UIAlertAction) -> Void in
                self.delegate.vkActionSheetAction(self._ACTION_SHEET_TYPE, buttonIndex: i, buttonTitle: arrTitle[i], object: self._string)
            }))
        }
        obj_AppDelegate.navigationController.present(alertController, animated: true, completion: nil)
    }
}
