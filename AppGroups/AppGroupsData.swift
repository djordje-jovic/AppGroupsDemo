//
//  AppGroupsData.swift
//  AppGroups
//
//  Created by Djordje Jovic on 8.10.21..
//

import Foundation

struct AppGroupsData {
    
    private static let appGroup = "group.E8C46L5TFQ.com.gge.appgroups"
    private let groupUserDefaults = UserDefaults(suiteName: appGroup)!
    private init() { }
    
    static let shared = AppGroupsData()
    
    private struct Config {
        private init() { }
        
        static let textKey = "kTextKey"
    }
    
    func saveText(_ text: String) {
        groupUserDefaults.set(text, forKey: Config.textKey)
    }
    
    func getText() -> String {
        groupUserDefaults.value(forKey: Config.textKey) as? String ?? ""
    }
}
