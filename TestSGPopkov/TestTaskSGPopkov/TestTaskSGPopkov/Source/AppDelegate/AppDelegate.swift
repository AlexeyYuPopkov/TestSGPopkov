//
//  AppDelegate.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var components: ComponentsAssemblyProtocol = ComponentsAssembly.shared
    lazy var navigationAssembly: NavigationAssemblyProtocol = NavigationAssembly(componentsAssembly: components)
    lazy var applicationRouter: ApplicationRouterProtocol = ApplicationRouter(navigationAssembly: navigationAssembly)


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        setupWindow()
        return true
    }
    
    private func setupWindow()
    {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        applicationRouter.initialWindow = self.window
        self.window?.rootViewController = self.applicationRouter.initialVC()
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

