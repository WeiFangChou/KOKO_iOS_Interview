//
//  FriendNavigationController.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/10.
//

import UIKit

class FriendNavigationController: UINavigationController {
	lazy var atmNavigationButton: UIBarButtonItem = {
		let btn = UIBarButtonItem(image: .icNavPinkWithdraw, style: .done, target: self, action: #selector(handlerATMButtonClicked))
		return btn
	}()

	lazy var transformNavigationButton: UIBarButtonItem = {
		let btn = UIBarButtonItem(image: .icNavPinkTransfer, style: .done, target: self, action: #selector(handlerTransformButtonClicked))
		return btn
	}()

	lazy var scannerNavigationButton: UIBarButtonItem = {
		let btn = UIBarButtonItem(image: .icNavPinkScan, style: .done, target: self, action: #selector(handlerScannerButtonClicked))
		return btn
	}()

	init() {
		super.init(nibName: nil, bundle: nil)
		setupUI()
		setupNavigationBar()
	}

	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		setupUI()
		setupNavigationBar()
	}

	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}

	func setupUI() {}

	func setupNavigationBar() {
		navigationBar.topItem?.setLeftBarButtonItems([atmNavigationButton, transformNavigationButton], animated: true)
		navigationBar.topItem?.setRightBarButtonItems([scannerNavigationButton], animated: true)

		navigationBar.tintColor = .hotPink
		navigationBar.backgroundColor = .whiteTwo
	}
}

extension FriendNavigationController {
	@objc func handlerATMButtonClicked() {}
	@objc func handlerTransformButtonClicked() {}
	@objc func handlerScannerButtonClicked() {}
}

@available(iOS 17, *)
#Preview {
	FriendNavigationController(rootViewController: FriendViewController())
}
