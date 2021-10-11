//
//  AppGroupsData.swift
//  AppGroups
//
//  Created by Djordje Jovic on 8.10.21..
//

import Foundation
import UIKit

struct AppGroupsData {
    
    private static let appGroup = "group.E8C46L5TFQ.com.gge.appgroups"
    private let groupUserDefaults = UserDefaults(suiteName: appGroup)!
    private let fileManager = FileManager.default
    private init() { }
    
    static let shared = AppGroupsData()
    
    private struct Config {
        private init() { }
        
        static let textKey = "kTextKey"
        static let imagesPath = "demoImage.png"
    }
    
    func saveText(_ text: String) {
        groupUserDefaults.set(text, forKey: Config.textKey)
    }
    
    func getText() -> String {
        groupUserDefaults.value(forKey: Config.textKey) as? String ?? ""
    }
    
    func saveImage(_ image: UIImage) {
        guard let imageUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: AppGroupsData.appGroup)?.appendingPathComponent(Config.imagesPath) else { fatalError() }
        guard let imageData = image.pngData() else { fatalError() }
        let foo = fileManager.createFile(atPath: imageUrl.path as String, contents: imageData, attributes: nil)
        print(foo)
    }
    
    func getImage() -> UIImage {
        let imageUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: AppGroupsData.appGroup)!.appendingPathComponent(Config.imagesPath)
        guard let image = UIImage(contentsOfFile: imageUrl.path) else { return UIImage(named: "default_image")! }
        return image
    }
}
