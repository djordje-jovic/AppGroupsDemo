//
//  AppGroupsData.swift
//  AppGroups
//
//  Created by Djordje Jovic on 8.10.21..
//

import Foundation
import UIKit
import SwiftKeychainWrapper

struct AppGroupsData {
    
    private static let teamID = "E8C46L5TFQ"
    private static let appGroup = "group.\(teamID).com.gge.appgroups"
    private static let appGroupKeychain = "\(teamID).com.gge.sharedkeychain"
    private let groupUserDefaults = UserDefaults(suiteName: appGroup)!
    private let fileManager = FileManager.default
    private let keychain = KeychainWrapper(serviceName: "shared-keychain-service", accessGroup: appGroupKeychain)
    private init() { }
    
    static let shared = AppGroupsData()
    
    private struct Config {
        private init() { }
        
        static let textKey = "kTextKey"
        static let imagesPath = "demoImage.png"
    }
}

// MARK: - Text
extension AppGroupsData {
    
    func saveText(_ text: String) {
        groupUserDefaults.set(text, forKey: Config.textKey)
    }
    
    func getText() -> String {
        groupUserDefaults.value(forKey: Config.textKey) as? String ?? ""
    }
}

// MARK: - Image
extension AppGroupsData {
    
    func saveImage(_ image: UIImage) {
        guard let imageUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: AppGroupsData.appGroup)?.appendingPathComponent(Config.imagesPath) else { fatalError() }
        guard let imageData = image.rotateImage().pngData() else { fatalError() }
        let foo = fileManager.createFile(atPath: imageUrl.path as String, contents: imageData, attributes: nil)
        print(foo)
    }
    
    func getImage() -> UIImage {
        let imageUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: AppGroupsData.appGroup)!.appendingPathComponent(Config.imagesPath)
        guard let image = UIImage(contentsOfFile: imageUrl.path) else { return UIImage(named: "default_image")! }
        return image.rotateImage()
    }
}

// MARK: - Keychain
extension AppGroupsData {
    
    func saveKeychainItem(_ item: String) {
        keychain.set(item, forKey: Config.textKey)
    }
    
    func readKeychainItem() -> String {
        return keychain.string(forKey: Config.textKey) ?? ""
    }
}
