//
//  DataModel.swift


//MARK: GENERAL
//**************************GENERAL***************************************************
let NS_FINGERPRINT                              = "NS_FINGERPRINT"
let NS_USER_NAME                                = "USER_NAME "
let SET_LOGOUT                                  = "0"

let NS_SERVICE_URL                              = "NS_SERVICE_URL"
let NS_UDID                                     = "NS_UDID"
let NS_USER_INFO                                = "NS_USER_INFO"
let NS_IS_LAUNCH_FIRST_TIME                     = "NS_IS_LAUNCH_FIRST_TIME"
let NS_SIDE_MENU                                = "NS_SIDE_MENU"
let NS_SUB_MENU                                 = "NS_SUB_MENU"
let NS_NOTIFICATION_BADGE                       = "NS_NOTIFICATION_BADGE"


//MARK: CLASS

import UIKit
import AddressBookUI


class DataModel: NSObject {
    
    //MARK: NS USER DEFAULTS 7b3df476eea46e9f5b3a29a690260b35
    class func setFingerprint(_ Value : String) {
        UserDefaults.standard.setValue(Value, forKey: NS_FINGERPRINT)
        UserDefaults.standard.synchronize()
    }
    class func getFingerprint() -> String {
        return (UserDefaults.standard.value(forKey: NS_FINGERPRINT) as! String)
    }
    class func setUsername(_ Value : String) {
        UserDefaults.standard.setValue(Value, forKey: NS_USER_NAME)
        UserDefaults.standard.synchronize()
    }
    class func getUsername() -> String {
        return (UserDefaults.standard.value(forKey: NS_USER_NAME) as! String)
    }
    
    class func setUDID(_ udid: String) {
        UserDefaults.standard.setValue(udid, forKey:NS_UDID)
        UserDefaults.standard.synchronize()
    }
    
    class func getUDID() -> String {
        var udid: String = ""
        if UserDefaults.standard.value(forKey: NS_UDID) != nil {
            udid = (UserDefaults.standard.value(forKey: NS_UDID) as! String)
        }
        return udid
    }
    class func getIsLaunchFirstTime() -> String {
        var stLft: String = ""
        if UserDefaults.standard.value(forKey: NS_IS_LAUNCH_FIRST_TIME) != nil {
            stLft = (UserDefaults.standard.value(forKey: NS_IS_LAUNCH_FIRST_TIME) as! String)
        }
        return stLft
//        return (UserDefaults.standard.value(forKey: NS_IS_LAUNCH_FIRST_TIME) as! String)
    }
    class func setIsLaunchFirstTime(_ Value : String) {
        UserDefaults.standard.setValue(Value, forKey: NS_IS_LAUNCH_FIRST_TIME)
        UserDefaults.standard.synchronize()
    }
    
    
    
   
    
    class func setSideMenu(_ array: [AnyObject]) {
        UserDefaults.standard.setValue(array, forKey:NS_SIDE_MENU)
        UserDefaults.standard.synchronize()
    }
    
    class func setSubSideMenu(_ array: [typeAliasDictionary]) {
        UserDefaults.standard.set(array, forKey:NS_SUB_MENU)
        UserDefaults.standard.synchronize()
    }
    class func getSideMenu() -> [typeAliasDictionary] {
        var arry = [typeAliasDictionary]()
        if UserDefaults.standard.object(forKey: NS_SIDE_MENU) != nil { arry = UserDefaults.standard.object(forKey: NS_SIDE_MENU) as! [typeAliasDictionary] }
        return arry
    }
    
    class func setUserInfo(_ dict: typeAliasDictionary) {
        UserDefaults.standard.set(dict, forKey:NS_USER_INFO)
        UserDefaults.standard.synchronize()
    }
    
    class func getUserInfo() -> typeAliasDictionary {
        var dictUserInfo = typeAliasDictionary()
        if UserDefaults.standard.object(forKey: NS_USER_INFO) != nil { dictUserInfo = UserDefaults.standard.object(forKey: NS_USER_INFO) as! typeAliasDictionary }
        return dictUserInfo
    }
    
    
    class func isDictionaryAndNotNull(data: Any) -> Bool {
        if !(data is NSNull) && data is typeAliasDictionary {
            let dict: typeAliasDictionary = data as! typeAliasDictionary
            if dict.count != 0 {
                return true
            }
        }
        return false
    }
    
    class func removeNull( fromDictionary dictionary: typeAliasDictionary) -> typeAliasDictionary {
        var dictionary = dictionary
        for pKey: String in dictionary.keys {
            if (dictionary[pKey] is NSNull) {
                dictionary[pKey] = "" as AnyObject?
            }
        }
        return dictionary
    }
    
    class func removeNullFromDictionary(dictionary: typeAliasDictionary) -> typeAliasDictionary {
        var dictionaryNew: typeAliasDictionary = dictionary
        for pKey in dictionaryNew.keys {
            if dictionaryNew[pKey] is [typeAliasDictionary] {
                var array: [typeAliasDictionary] = dictionaryNew[pKey] as! [typeAliasDictionary]
                for i in 0..<array.count {
                    let dictArray: typeAliasDictionary = array[i]
                    var dict: typeAliasDictionary = dictArray
                    dict = self.removeNullFromDictionary(dictionary: dict)
                    array[i] = dict
                }
                dictionaryNew[pKey] = array as AnyObject?
            }
            if dictionaryNew[pKey] is typeAliasDictionary {
                var dict: typeAliasDictionary = dictionaryNew[pKey] as! typeAliasDictionary
                dict = self.removeNullFromDictionary(dictionary: dict)
                dictionaryNew[pKey] = dict as AnyObject?
            }
            if dictionaryNew[pKey] is NSNull {
                dictionaryNew[pKey] = "" as AnyObject?
            }
        }
        return dictionaryNew
    }

  
    class func setNotificationBadge(_ fees: String) {
        UserDefaults.standard.setValue(fees, forKey:NS_NOTIFICATION_BADGE)
        UserDefaults.standard.synchronize()
    }
    
    class func getNotificationBadge() -> String {
        return UserDefaults.standard.value(forKey: NS_NOTIFICATION_BADGE) != nil ? (UserDefaults.standard.value(forKey: NS_NOTIFICATION_BADGE) as! String) : ""
    }
    
    
    class func resetPList() {
        let dictUserInfo = typeAliasDictionary()
        DataModel.setUserInfo(dictUserInfo)
    }
    
    //MARK: CUSTOM METHODS
    class func validateMobileNo(_ mobileNo: String) -> Bool {
        do {
            /*
             ^     #Match the beginning of the string
             [789] #Match a 7, 8 or 9
             \d    #Match a digit (0-9 and anything else that is a "digit" in the regex engine)
             {9}   #Repeat the previous "\d" 9 times (9 digits)
             $     #Match the end of the string
             */
            
            let pattern: String = "^[789]\\d{9}$"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = mobileNo as NSString
            let results = regex.matches(in: mobileNo, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    class func validateEmail(_ email: String) -> Bool {
        do {
            let pattern: String = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = email as NSString
            let results = regex.matches(in: email, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    class func validatePassword(_ password: String) -> Bool {
        return password.characters.count >= 6 && password.characters.count <= 32 ? true : false
    }
    
    class func getDeviceName() -> String {
        return UIDevice.current.name
    }
    
    class func getVendorIdentifier() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    class func getAppVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
       class func removeThousandSeperator(_ string: String)->String{
        
        let decimal = string.components(separatedBy: ".")
        let intString = decimal[0].components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let Price = intString + "." + decimal[1]
        return Price
    }
    
    class func isContainString(_ string: String, subString: String) -> Bool {
        if (string as NSString).range(of: subString).location != NSNotFound {
            return true
        }
        else {
            return false
        }

    }
    
    class func setThousandSeperator(_ string: String)->String
    {
      return  self.setThousandSeperator(string, decimal: 2)
    }
    
    class func setThousandSeperator(_ string:String , decimal:Int)->String
    {
        let numberFormatter = NumberFormatter.init()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = decimal
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.currencySymbol = ""
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter.string(from: NSNumber.init(value: Double(string)! as Double))!
              
    }
    
   class func setDecimalPoint(_ str:String)->String{
        let numberFormatter:NumberFormatter = NumberFormatter.init()
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = 2
        return  numberFormatter.string(from: NSNumber.init(value: Double(str)! as Double))!
    }
    
    class func getDocumentDirectoryPath() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    class func getDataFromDocumentDirectory(fileName: String, folderName: String) -> NSData? {
        let documentsDirectory = self.getDocumentDirectoryPath()
        let fileManager = FileManager.default
        let fileName1: String = "\(documentsDirectory)\(folderName)\(fileName)"
        if fileManager.fileExists(atPath: fileName1) {
            return NSData(contentsOfFile: fileName1)
        }
        return nil
    }
    class func GetFontNames()
    {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
            print("Font Names = [\(names)]")
        }
    }
    class func getDocumentDirectoryPath(_ filename: String, folderName: String) -> String {
        let documentsDirectory = self.getDocumentDirectoryPath()
        let dataPath: String = folderName.characters.isEmpty ? documentsDirectory : documentsDirectory + "/" + folderName
        
        if !FileManager.default.fileExists(atPath: dataPath) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath, withIntermediateDirectories: false, attributes: nil)
            } catch { print("Folder creation error : \(error.localizedDescription)") }
        }
        return dataPath + "/"
    }
    
    class func writeDataAtPath(filePath: String, fileData: Data, isOverWriteOld: Bool) -> Bool {
        let fileManager: FileManager = FileManager.default
        
        let writeFile = { () -> Bool in
            do {
                try fileData.write(to: URL.init(fileURLWithPath: filePath), options: .atomic)
                return true
            } catch { print("File write error : \(error.localizedDescription)") }
            return false
        }
        
        if fileManager.fileExists(atPath: filePath) && isOverWriteOld {
            do {
                try fileManager.removeItem(atPath: filePath)
                return writeFile()
            } catch { print("File remove error : \(error.localizedDescription)") }
        }
        else { return writeFile() }
        return false
    }
    struct NetInfo {
        let ip: String
        let netmask: String
    }

    class func getIPAddress() -> String {
    
    var addresses = [NetInfo]()
    
    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        
        var ptr = ifaddr;
        while ptr != nil {
            
            let flags = Int32((ptr?.pointee.ifa_flags)!)
            var addr = ptr?.pointee.ifa_addr.pointee
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr?.sa_family == UInt8(AF_INET) || addr?.sa_family == UInt8(AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr!, socklen_t((addr?.sa_len)!), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        if let address = String.init(validatingUTF8:hostname) {
                            
                            var net = ptr?.pointee.ifa_netmask.pointee
                            var netmaskName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            getnameinfo(&net!, socklen_t((net?.sa_len)!), &netmaskName, socklen_t(netmaskName.count),
                                        nil, socklen_t(0), NI_NUMERICHOST)// == 0
                            if let netmask = String.init(validatingUTF8:netmaskName) {
                                addresses.append(NetInfo(ip: address, netmask: netmask))
                            }
                        }
                    }
                }
            }
            ptr = ptr?.pointee.ifa_next
        }
        freeifaddrs(ifaddr)
    }
    return (addresses.last?.ip)!
    }
}

//http://stackoverflow.com/questions/26028918/ios-how-to-determine-iphone-model-in-swift
