//
//  TabBarController.swift
//  Exschange
//
//  Created by Arman Davidoff on 26.10.2020.
//

import UIKit



class TabBarController: UITabBarController {
    
    var bidViewController: UIViewController!
    var askViewController: UIViewController!
    
    override func viewDidLoad() {
        
        let startSelectedCurrency = CurrencyModel.getLocalValues().first!
        let bidVc = AskBidViewController(selectedCurrency: startSelectedCurrency, vcType: .bidVC)
        let askVc = AskBidViewController(selectedCurrency: startSelectedCurrency, vcType: .askVC)
        
        tabBar.tintColor = VCType.bidVC.color
        
        bidViewController = createController(type: .bidVC,rootVC: bidVc)
        askViewController = createController(type: .askVC,rootVC: askVc)
        
        self.viewControllers = [bidViewController,askViewController]
    }
    
    private func createController(type: VCType,rootVC: UIViewController) -> UIViewController {
        let nc = UINavigationController(rootViewController: rootVC)
        nc.navigationBar.topItem?.title = "Test Application"
        nc.navigationBar.barTintColor = .systemBackground
        nc.tabBarItem.title = type.rawValue
        nc.tabBarItem.image = UIImage(systemName: type.imageName)
    
        return nc
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let title = item.title, let vcType = VCType(rawValue: title)  else { return }
        tabBar.tintColor = vcType.color
    }
    
}
