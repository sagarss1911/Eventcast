//
//  VKActivtyIndicator.swift
//  
//
//  Created by Keyur on 05/01/18.
//  Copyright © 2018 jTechappz. All rights reserved.
//

import UIKit

class VKActivtyIndicator: UIView {
    
    //MARK: PROPERTIES
    var VKActivtyIndicatorSize: CGSize!
    var titleLabel: UILabel!;
    
    //MARK: VIEW METHODS
    override init(frame: CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        let frame: CGRect = UIScreen.main.bounds
        super.init(frame : frame)
        self.showIndicator(title)
    }
    
    fileprivate func showIndicator(_ title: String) {
        self.isOpaque = false;

        VKActivtyIndicatorSize = CGSize(width: 120, height: 120);
        
        // BG View
        let view: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: VKActivtyIndicatorSize.width, height: VKActivtyIndicatorSize.height));
        view.layer.cornerRadius = 10;
        view.backgroundColor = RGBCOLOR(0/255, g: 0/255, b: 0/255, alpha: 0.8)
        self.addSubview(view);
        
        // ACTIVITY INDICATOR
        let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 15, width: 60, height: 60));
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge;
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating();
        
        var center: CGPoint = activityIndicator.center;
        center.x = view.center.x;
        activityIndicator.center = center;
        
        view.addSubview(activityIndicator);
        
        view.center = self.center;
        
        self.titleLabel = UILabel.init(frame: CGRect(x: 0, y: activityIndicator.frame.maxY + 5, width: view.frame.width, height: 20));
        self.titleLabel.text = title;
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.textAlignment = NSTextAlignment.center;
        view.addSubview(self.titleLabel);
    }
}
