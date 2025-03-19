import UIKit

class TabbBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = SearchViewController()
        firstVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "house"), tag: 0)
        
        let secondVC = MatchViewController()
        secondVC.tabBarItem = UITabBarItem(title: "Match", image: UIImage(systemName: "house"), tag: 1)
        
        let thirdVC = ProfileViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "house"), tag: 2)
        
        self.viewControllers = [firstVC, secondVC, thirdVC]
    }
}
