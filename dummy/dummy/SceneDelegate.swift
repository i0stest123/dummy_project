//
//  SceneDelegate.swift
//  CurlNation
//
//  Created by Inovant Solutions on 31/12/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UITabBarControllerDelegate {
    
    var window: UIWindow?
    var isEnglish: Bool = true
    let activityLoader: ViewControllerUtils = ViewControllerUtils()
    var tabBarController:UITabBarController = UITabBarController()
    var selectedCountry:CountryObj = CountryObj()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
        
        if let windowScene = scene as? UIWindowScene{
            let window  = UIWindow(windowScene: windowScene)
            window.rootViewController = SplashViewController()
            window.backgroundColor = BgColor
            window.overrideUserInterfaceStyle = .light
            self.window = window
            window.makeKeyAndVisible()
        }
        
        //SetLanguage
        var firstRun = UserDefaults.standard.bool(forKey: "HasBuildBefore")
        if !firstRun {
            firstRun=true;
            UserDefaults.standard.set(firstRun, forKey: "HasBuildBefore")
            let lang = Locale.preferredLanguages[0]
            var isLangEn = true
            if lang.lowercased().range(of:"ar") != nil {
                isLangEn = false
            }
            UserDefaults.standard.set(isLangEn, forKey: "isEnglishLang")
        }
        isEnglish = UserDefaults.standard.bool(forKey: "isEnglishLang")
        
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
    }
    
    func SetupMenu() {
        self.setupNavigationAppearance()
        let isUserLogin : Bool = UserDefaults.standard.bool(forKey: "isUserLogin")
        if isUserLogin {
            appDelegate.userObj = Globals.LoadUserProfile()
        }
        
        Globals.setDefaultCountry()
        
        if Globals.isEnglishLang() {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
        }else{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        self.tabBarController = UITabBarController()
        self.tabBarController.delegate = self
        self.tabBarController.tabBar.backgroundColor = TabBarBgcolor
        self.tabBarController.hidesBottomBarWhenPushed = true
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = TabBarBgcolor
        
        self.tabBarController.viewControllers =  sceneDelegate.generateTabbarArray()
        self.tabBarController.selectedIndex = 0;
        self.tabBarController.tabBar.tintColor = TabBarTextColor;
        self.tabBarController.tabBar.unselectedItemTintColor = TabBarUnselectedTextColor
    
        self.window?.alpha = 0.0;
        self.window?.rootViewController = self.tabBarController;
        self.window?.backgroundColor = BgColor
        
        self.window?.rootViewController =  self.tabBarController
        window?.makeKeyAndVisible()
        UIView.transition(with: self.window!, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.window?.alpha=1.0;
        }, completion: { completed in
            // maybe do something here
        })
    }
    
    func setupNavigationAppearance(barColor:UIColor = NavBgColor){
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundColor = barColor
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: NavBarFont, size: NavFontsize)!, NSAttributedString.Key.foregroundColor:PrimaryTextColor]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        }
        
        UINavigationBar.appearance().backgroundColor = barColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = PrimaryTextColor
        UINavigationBar.appearance().barTintColor = PrimaryTextColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: NavBarFont, size: NavFontsize)!, NSAttributedString.Key.foregroundColor:PrimaryTextColor]
    }
    
    func generateTabbarArray() -> [UIViewController]{
        let homeVc = HomeViewController()
        homeVc.navigationItem.titleView = self.returnLogoView();
        
        let CategoryVC = CategoryViewController()
        CategoryVC.navigationItem.titleView = self.returnLogoView();
        
        let brandVC = BrandsViewController()
        brandVC.navigationItem.titleView = self.returnLogoView();
        
        let asicaVc = ShopViewController()
        asicaVc.navigationItem.titleView = self.returnLogoView();
        
        let accountVC = AccountViewController()
        accountVC.navigationItem.titleView = self.returnLogoView();
        
        
        let v1 = UINavigationController(rootViewController: homeVc)
        let v2 = UINavigationController(rootViewController: CategoryVC)
        let v3 = UINavigationController(rootViewController: brandVC)
        let v4 = UINavigationController(rootViewController: asicaVc)
        let v5 = UINavigationController(rootViewController: accountVC)
        
        
        let tab1 = UITabBarItem.init(title: Globals.GetStringForKey(key:"Home"), image: UIImage(named: "HomeTabIcon"), tag: 0);
        v1.tabBarItem = tab1;
        
        let tab2 = UITabBarItem.init(title: Globals.GetStringForKey(key:"Categories"), image: UIImage(named: "CategoryTabIcon"), tag: 1);
        v2.tabBarItem = tab2;
        
        let tab3 = UITabBarItem.init(title: Globals.GetStringForKey(key:"Brands"), image: UIImage(named: "BrandTabIcon"), tag: 2);
        v3.tabBarItem = tab3;
        
        let tab4 = UITabBarItem.init(title: Globals.GetStringForKey(key:"Ascia"), image: UIImage(named: "ShopTabIcon"), tag: 3);
        v4.tabBarItem = tab4;
        
        let tab5 = UITabBarItem.init(title: Globals.GetStringForKey(key:"Account"), image: UIImage(named: "AccountTabIcon"), tag: 4);
        v5.tabBarItem = tab5;
        
        return [v1,v2,v3,v4,v5]
        
    }
    
    func returnLogoView() -> UIView{
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: DeviceWidth*DeviceMultiplier, height: 30*DeviceMultiplier))
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "SplashLogoIcon")
        imageView.image = image
        logoContainer.addSubview(imageView)
        imageView.centerX()
        imageView.centerY()
        imageView.fixHeight(constant: 30*DeviceMultiplier)
        imageView.fixWidth(constant: 320*DeviceMultiplier)
        
        return logoContainer
    }
    
    
}

