//
//  SceneDelegate.swift
//  iCol
//
//  Created by Muhammad Rasyid khaikal on 12/10/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        // MARK: Change the names later
        let viewController1 = ViewController1()
        viewController1.tabBarItem = UITabBarItem(title: "VC1", image: UIImage(systemName: "rosette"), tag: 0)
        let navController1 = UINavigationController(rootViewController: viewController1)
        
        let viewController2 = ViewController2()
        viewController2.tabBarItem = UITabBarItem(title: "VC2", image: UIImage(systemName: "book"), tag: 1)
        let navController2 = UINavigationController(rootViewController: viewController2)
        
        let viewController3 = ViewController3()
        viewController3.tabBarItem = UITabBarItem(title: "VC3", image: UIImage(systemName: "person"), tag: 2)
        let navController3 = UINavigationController(rootViewController: viewController3)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navController1, navController2, navController3]
        
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        window?.backgroundColor = .systemBackground
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

