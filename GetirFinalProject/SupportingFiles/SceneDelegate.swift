//
//  SceneDelegate.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 10.04.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
//        //MARK: - Start TEST CASE
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        let vc = tryUIViewController()
//        window.rootViewController = vc
//        self.window = window
//        self.window?.makeKeyAndVisible()
//        
//        
        
        
        
        
        
        //MARK: -  Original Case
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = ListingViewController()
        let nav = UINavigationController(rootViewController: vc)
        configureNavigationBarAppearance(for: nav)
        window.rootViewController = nav
        self.window = window
        self.window?.makeKeyAndVisible()
        
    }
    
    
    func configureNavigationBarAppearance(for navigationController: UINavigationController) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = CustomColor.getirPurple
            // setup font and text color
        
        appearance.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.openSansBold14, NSAttributedString.Key.foregroundColor: UIColor.white]
        
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
           
        }
    
    
    


}

