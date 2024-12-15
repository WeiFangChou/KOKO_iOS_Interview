//
//  HomeTabBarController.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/9.
//

import UIKit

class HomeTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupTabBars()
		setupSelectedIndex()
	}

	func setupUI() {}

	func setupSelectedIndex() {
		#if DEBUG
			selectedIndex = 1
		#else
			selectedIndex = 0
		#endif
	}

	func setupTabBars() {
		let tab1VC = HomeViewController()
		let nav1 = UINavigationController(rootViewController: tab1VC)
		let tab2VC = FriendViewController()
		let nav2 = FriendNavigationController(rootViewController: tab2VC)
		let tab3VC = KOKOViewController()
		let nav3 = UINavigationController(rootViewController: tab3VC)
		let tab4VC = MoneyViewController()
		let nav4 = UINavigationController(rootViewController: tab4VC)
		let tab5VC = SettingViewController()
		let nav5 = UINavigationController(rootViewController: tab5VC)

		tab1VC.tabBarItem = UITabBarItem(title: "錢錢", image: .icTabbarProductsOff2.withRenderingMode(.automatic), selectedImage: .icTabbarProductsOff2.withRenderingMode(.automatic))
		tab2VC.tabBarItem = UITabBarItem(title: "朋友", image: .icTabbarFriendsOn.withRenderingMode(.automatic), selectedImage: .icTabbarFriendsOn.withRenderingMode(.automatic))
		tab3VC.tabBarItem = UITabBarItem(title: "", image: .icTabbarHomeOff.withRenderingMode(.alwaysOriginal), selectedImage: .icTabbarHomeOff.withTintColor(.hotPink))
		tab4VC.tabBarItem = UITabBarItem(title: "記帳", image: .icTabbarManageOff.withRenderingMode(.automatic), selectedImage: .icTabbarManageOff.withRenderingMode(.automatic))
		tab5VC.tabBarItem = UITabBarItem(title: "設定", image: .icTabbarSettingOff.withRenderingMode(.alwaysOriginal), selectedImage: .icTabbarSettingOff.withRenderingMode(.alwaysOriginal))

		tabBar.tintColor = .hotPink
		tabBar.backgroundColor = .whiteTwo

		viewControllers = [nav1, nav2, nav3, nav4, nav5]
	}
}

@available(iOS 17, *)
#Preview {
	HomeTabBarController()
}
