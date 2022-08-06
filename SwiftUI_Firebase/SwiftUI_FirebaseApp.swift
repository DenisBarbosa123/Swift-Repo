//
//  SwiftUI_FirebaseApp.swift
//  SwiftUI_Firebase
//
//  Created by Paulo Siecola on 21/05/22.
//

import SwiftUI
import Firebase
import FirebaseStorageUI

@main
struct SwiftUI_FirebaseApp: App {
    init() {
        FirebaseApp.configure()
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 60
        remoteConfig.configSettings = settings
        
        let defaults: [String: Any?] = [
            "delete_list_view" : true
        ]
        
        remoteConfig.setDefaults(defaults as? [String: NSObject])
        
        remoteConfig.fetchAndActivate { (status, error) -> Void in
            if status == .successFetchedFromRemote {
                print("The RemoteConfig has been fetched!")
            } else {
                print("RemoteConfig not fetched")
            }
        }
        
        let cache = SDImageCache(namespace: "tiny")
        cache.config.maxMemoryCost = 100 * 1024 * 1024 // 100MB memory
        cache.config.maxDiskSize = 50 * 1024 * 1024 // 50MB disk
        SDImageCachesManager.shared.addCache(cache)
        SDWebImageManager.defaultImageCache = SDImageCachesManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
