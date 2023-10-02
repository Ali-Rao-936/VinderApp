//
//  TabBarVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import CoreImage

class TabBarVC: UITabBarController,UITabBarControllerDelegate {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
          super.viewDidLoad()

        tabBarController?.tabBar.tintColor = UIColor.white
//        tabBar.unselectedItemTintColor = primaryColor
        tabBar.tintColor = UIColor.systemYellow
//        tabBar.selectedImageTintColor = UIColor.systemYellow
        
//        UITabBar.appearance().selectedItem
        UITabBar.appearance().unselectedItemTintColor  = UIColor.white
        tabBar.backgroundColor = primaryColor
//        tabBar.inputView?.heightAnchor = 70
//        tabBar.inputView?.layer.cornerRadius = 30
//        tabBar.backgroundImage = UIImage(named: "tabBgImg")
        
        
//        let bgView = UIImageView(image: UIImage(named: "tabBgImg"))
//        bgView.frame = self.tabBar.bounds
//        self.tabBar.addSubview(bgView)
//        self.tabBar.sendSubviewToBack(bgView)
//        self.tabBar.sendSubview(toBack: bgView)
        
        ///
//        self.tabBar.layer.masksToBounds = true
//        self.tabBar.layer.cornerRadius = 30 // whatever you want
//        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner] // only the top right and left corners
        
//          setupViewController()
//          setupUI()
//          self.delegate = self
    }


    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        tabBar.frame.size.height = 95
//        tabBar.frame.origin.y = view.frame.height - 95
        
//
//        if UIDevice().screenType == .iPhones_6_6s_7_8 || UIDevice().screenType == .iPhones_5_5s_5c_SE || UIDevice().screenType == .iPhones_4_4S{
//            tabBar.frame.size.height = 100
//            tabBar.frame.origin.y = view.frame.height - 60
//        }
//        if  size == false {
//
//            tabBar.frame.size.height = 100
//            tabBar.frame.origin.y = view.frame.height - 60
//
//        }
    }

      func setupUI() {

//          let blurEffect = UIBlurEffect(style: .dark) // here you can change blur style
//          let blurView = UIVisualEffectView(effect: blurEffect)
//          blurView.frame = tabBar.bounds
//          blurView.alpha = 0.6
//          blurView.autoresizingMask = .flexibleWidth
//
//          tabBar.insertSubview(blurView, at: 0)

          
          tabBar.backgroundImage = UIImage()
      }


      func setupViewController() {

          viewControllers = [homeTab,walletTab,wishlistTab,bookingsTab]
      }

    // ================ checkLogin and style ===============================
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//
//        let tabBarIndex = tabBarController.selectedIndex
//
////        whenPress(indexPathSelected:tabBarIndex)
//        if let item = tabBar.selectedItem {
//            for item in tabBar.items ?? [] {
//                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
//                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                }
//
//                item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -15, right: 0)
//                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 50)
//        }
//
    }

// ===========================================================
    // MARK: - TabItems
    
     var homeTab: UIViewController = {
         let homeTabItem = UITabBarItem(title: "Home", image: UIImage(named: "tabMenu-1"), selectedImage: UIImage(named: "filledHome-tabBar")?.withRenderingMode(.alwaysOriginal))
         let homeNavTab = UINavigationController(rootViewController: HomeVC()) // BaseNavigation(rootViewController: HomeVC())
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    var walletTab: UIViewController = {
        let searchTabItem = UITabBarItem(title: "Explore", image: UIImage(named: "tabMenu-2"), selectedImage: UIImage(named: "filledWallet-tabBar")?.withRenderingMode(.alwaysOriginal))
        let navController = UINavigationController(rootViewController: ExploreUserVC()) // BaseNavigation(rootViewController: HomeVC())
        navController.tabBarItem = searchTabItem
       return navController
        
//        let MainView = (storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as? InitialVC)!
//        let navController = UINavigationController.init(rootViewController: MainView)
//
//        self.navigationController?.navigationBar
//        let navController = BaseNavigation(rootViewController: ExploreUserVC())
//        navController.tabBarItem = searchTabItem
        
//        return navController
    }()

     var wishlistTab: UIViewController = {
         let eventsTabItem = UITabBarItem(title: "Events", image: UIImage(named: "tabMenu-3"), selectedImage: UIImage(named: "filledWishlist-tabBar")?.withRenderingMode(.alwaysOriginal))
         
//         let searchTabItem = UITabBarItem(title: "Explore", image: UIImage(named: "tabMenu-2"), selectedImage: UIImage(named: "filledWallet-tabBar")?.withRenderingMode(.alwaysOriginal))
         let navController = UINavigationController(rootViewController: EventsVC()) // BaseNavigation(rootViewController: HomeVC())
         navController.tabBarItem = eventsTabItem
        return navController
         
//        let navController = BaseNavigation(rootViewController: EventsVC())
//        navController.tabBarItem = likeTabItem
//        return navController
    }()

     var bookingsTab: UIViewController = {
         let chatsTabItem = UITabBarItem(title: "Chats", image: UIImage(named: "tabMenu-4"), selectedImage: UIImage(named: "filledBookings-tabBar")?.withRenderingMode(.alwaysOriginal))
        let navController = UINavigationController(rootViewController: MainChatVC())  //BaseNavigation(rootViewController: MainChatVC())
        navController.tabBarItem = chatsTabItem
        return navController
    }()

  }



extension UITabBar {
    func addBlurEffectWithColor(blurColor: UIColor) {
        // Create a blur effect with a given style
        let blurEffect = UIBlurEffect(style: .regular)
        
        // Create a visual effect view with the blur effect
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Set the frame of the visual effect view to match the tab bar's bounds
        visualEffectView.frame = bounds
        
        // Add the visual effect view to the tab bar
        addSubview(visualEffectView)
        
        // Create a color view to apply the desired background color
        let colorView = UIView(frame: CGRect(x: 0, y: -10, width: bounds.width, height: bounds.height + 10))
        colorView.backgroundColor = blurColor
        
        // Set the opacity of the color view to adjust the intensity of the color
        colorView.alpha = 0.8
        
        // Add the color view as a subview of the visual effect view
        visualEffectView.contentView.insertSubview(colorView, at: 1)
    }
}
