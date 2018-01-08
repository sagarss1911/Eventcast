//
//  Extensions.swift
//
//
//  Created by Keyur on 05/01/18.
//  Copyright © 2018 jTechappz. All rights reserved.
//

import Foundation
import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

extension String {
    
    func localized(forLanguage language: String = Locale.preferredLanguages.first!.components(separatedBy: "-").first!) -> String {
            guard let path = Bundle.main.path(forResource: language == "en" ? "Base" : language, ofType: "lproj") else {
            let basePath = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            return Bundle(path: basePath)!.localizedString(forKey: self, value: "", table: nil)
        }
        return Bundle(path: path)!.localizedString(forKey: self, value: "", table: nil)
    }
}

extension UIViewController {
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


extension UITextField {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autocapitalizationType = UITextAutocapitalizationType.none;
        self.autocorrectionType = UITextAutocorrectionType.no;
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.rightViewMode = UITextFieldViewMode.always;
        self.rightView = view;
    
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(UITextField.viewClick))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        
        let toolbar = UIToolbar.init()
        toolbar.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(btnBarDoneAction))
        toolbar.barTintColor = COLOUR_NAV
        toolbar.tintColor = UIColor.white
        toolbar.items = [barBtnDone]
        toolbar.alpha = 0.8
        self.inputAccessoryView = toolbar
        
        if self.keyboardType == UIKeyboardType.default {
            
        }
    }

    @objc func viewClick() {
        self.becomeFirstResponder();
    }
    
    @objc func btnBarDoneAction() { self.resignFirstResponder() }
}

extension UIButton {
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let relativeFrame = self.bounds
        let hitTestEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
        return hitFrame.contains(point)
    }
}
    extension UIImage
    {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
extension UILabel{
    func estimatedHeightOfLabel() -> CGFloat {
        
        let size = CGSize(width: self.frame.width - 16, height: CGFloat.greatestFiniteMagnitude)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)]
        
        let rectangleHeight = String(self.text!).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return rectangleHeight+5
    }
    func textHeight(_ textWidth: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = String(self.text!).boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: textFont], context: nil)
        let textSize: CGSize = textRect.size;
        
        return self.text! == "" ? 0.0 : textSize.height
    }
    func estimatedTextWidth() -> CGFloat {

        let font = UIFont(name:FONT_SOURCE_SANS_PRO_REGULAR, size: 16)
        let fontAttributes = [NSAttributedStringKey.font: font] // it says name, but a UIFont works
        let size = (self.text)?.size(withAttributes: fontAttributes)
        return size?.width > 325 ? 325 : size?.width < 75 ? 95
            : (size!.width + 30)
    }
}
extension String {
    
    mutating func replace(_ string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString)
    }
    
    mutating func replaceWhiteSpace(_ withString: String) -> String {
        let components = self.components(separatedBy: CharacterSet.whitespaces)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: "")
    }
    
    func textWidth(_ textHeight: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: textHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.width)
    }
    
    func textSize(_ textFont: UIFont) -> CGSize {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: textFont], context: nil)
        return textRect.size;
    }
    
    func trim() -> String { return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    mutating func extractPhoneNo() -> String {
        self = self.trim()
        /* self = self.replaceWhiteSpace("")
         self = self.replace("(", withString: "")
         self = self.replace(")", withString: "")
         self = self.replace("+81", withString: "")
         self = self.replace("+82", withString: "")
         self = self.replace("+84", withString: "")
         self = self.replace("+63", withString: "")
         self = self.replace("+63", withString: "")
         self = self.replace("+66", withString: "")
         self = self.replace("+", withString: "")
         self = self.hasPrefix("0") ? self.replace("0", withString: "") : self
         self = self.replace("-", withString: "") */
        return self
    }
    func leftPadding(toLength: Int, withPad: String = " ") -> Int {
        
        guard toLength > self.characters.count else { return Int(self)! }
        
        let padding = String(repeating: withPad, count: toLength - self.characters.count)
        return Int(padding + self)!
    }
    
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
    
    func convertToUrl() -> URL {
        let data:Data = self.data(using: String.Encoding.utf8)!
        var resultStr: String = String(data: data, encoding: String.Encoding.nonLossyASCII)!
        
        if !(resultStr.hasPrefix("itms://")) && !(resultStr.hasPrefix("file://")) && !(resultStr.hasPrefix("http://")) && !(resultStr.hasPrefix("https://")) { resultStr = "http://" + resultStr }
        
        resultStr = resultStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL(string: resultStr)!
    }
    
    mutating func encode() -> String {
        let customAllowedSet =  CharacterSet(charactersIn:" !+=\"#%/<>?@\\^`{|}$&()*-").inverted
        self = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        return self
    }
    
    func isNumeric() -> Bool {
        var holder: Float = 0.00
        let scan: Scanner = Scanner(string: self)
        let RET: Bool = scan.scanFloat(&holder) && scan.isAtEnd
        if self == "." { return false }
        return RET
    }
    
    func isContainString(_ subString: String) -> Bool {
        let range = self.range(of: subString, options: NSString.CompareOptions.caseInsensitive, range: self.range(of: self))
        return range == nil ? false : true
    }
    
    func convertToDictionary() -> typeAliasStringDictionary {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let dict: typeAliasStringDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! typeAliasStringDictionary
            return dict
        } catch let error as NSError { print(error) }
        
        return typeAliasStringDictionary()
    }
    
    func convertToDictionary2() -> typeAliasDictionary {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let dict: typeAliasDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! typeAliasDictionary
            return dict
        } catch let error as NSError { print(error) }
        return typeAliasDictionary()
    }
    
    func convertToArray() -> [typeAliasDictionary] {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let array: [typeAliasDictionary] = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! [typeAliasDictionary]
            return array
        } catch let error as NSError { print(error) }
        
        return [typeAliasDictionary]()
    }
    
    func base64Encoded() -> String {
        if let data = self.data(using: .utf8) { return data.base64EncodedString() }
        return ""
    }
    
    func base64Decoded() -> String {
        if let data = Data(base64Encoded: self) { return String(data: data, encoding: .utf8)! }
        return ""
    }
    
    func hexToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        
        if ((cString.characters.count) != 6) { return UIColor.gray }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getRediansFromDegrees() -> Double {
        let degree: Double = Double(self)!
        return degree * M_PI / 180.0
    }
    
    func extractString(_ checkingType: NSTextCheckingResult.CheckingType) -> [String] {
        var arrText = [String]()
        let detector = try! NSDataDetector(types: checkingType.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        for match in matches {
            let url = (self as NSString).substring(with: match.range)
            arrText.append(url)
        }
        return arrText
    }
    
    func getPhoneNumber() -> [String] { return self.extractString(.phoneNumber) }
    
    func getUrl() -> [String]  { return self.extractString(.link) }
    
    func getAddress() -> [String]  { return self.extractString(.address) }
    
    func getEmail() -> [String]  {
        var arrEmail = [String]()
        let arrText = self.components(separatedBy: ["\n"," "])
        for st in arrText {
            let isEmail: Bool = DataModel.validateEmail(st)
            if isEmail { arrEmail.append(st) }
        }
        return arrEmail
    }
    
    var getIntergerFromString: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .flatMap { pattern ~= $0 ? Character($0) : nil })
    }
}

extension Dictionary {
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            return st as String
        } catch let error as NSError { print(error) }
        return ""
    }
}

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.characters.index(string.startIndex, offsetBy: location)
        let endIndex = string.characters.index(startIndex, offsetBy: length)
        return startIndex..<endIndex
    }
}

extension UIView {
    
    func round(corners: UIRectCorner, radius: CGFloat) -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func setHighlight() {
        self.setViewBorder(COLOUR_NAV, borderWidth: 2, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func unSetHighlight() {
        self.setViewBorder(COLOUR_TEXTFIELD_BORDER, borderWidth: 1, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func setBottomBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        let tagLayer: String = "100000"
        if self.layer.sublayers?.count > 1 && self.layer.sublayers?.last?.accessibilityLabel == tagLayer {
            self.layer.sublayers?.last?.removeFromSuperlayer()
        }
        let border: CALayer = CALayer()
        border.backgroundColor = borderColor.cgColor;
        border.accessibilityLabel = tagLayer;
        border.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth);
        self.layer.addSublayer(border)
    }
    
    func setViewBorder(_ borderColor: UIColor, borderWidth: CGFloat, isShadow: Bool, cornerRadius: CGFloat, backColor: UIColor) {
        self.backgroundColor = backColor;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor;
        self.layer.cornerRadius = cornerRadius;
        if isShadow { self.setShadowDrop(self) }
    }
    
    func setShadowDrop(_ view: UIView) {
        //http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow
        
        let layer: CALayer = view.layer
        layer.shadowOffset = CGSize(width: 1, height: 1);
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowRadius = 4.0;
        layer.shadowOpacity = 0.20;
        //layer.shadowPath = UIBezierPath(roundedRect: layer.bounds);
    }
}

extension UIButton {
}

extension UISegmentedControl {
}


extension UIView {
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension URL {
    func getDataFromQueryString() -> typeAliasStringDictionary {
        let urlComponents: URLComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        let arrQueryItems: Array<URLQueryItem> = urlComponents.queryItems!
        var dictParams = typeAliasStringDictionary()
        for item:URLQueryItem in arrQueryItems { dictParams[item.name] = item.value }
        return dictParams
    }
}

public extension UIDevice {
    
    public var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
