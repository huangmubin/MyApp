//
//  AppDelegate.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        try! FileManager.default.createDirectory(
            atPath: "\(NSHomeDirectory())/Documents/Images/",
            withIntermediateDirectories: true,
            attributes: nil
        )
        print(NSHomeDirectory())
        
        SQLite.default.open()
        SQLite.Habit.create()
        SQLite.Log.create()
        SQLite.Chart.create()
        SQLite.ChartUnit.create()
        SQLite.Event.create()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        SQLite.default.close()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        SQLite.default.open()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        SQLite.default.close()
    }


}

