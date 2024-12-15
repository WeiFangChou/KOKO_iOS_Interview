//
//  SceneViewController.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/9.
//

import UIKit

class SceneViewController: UIViewController {
	lazy var sceneNoFriends: UIButton = {
		let btn = UIButton()
		btn.setTitle("無好友畫面", for: .normal)
		btn.addTarget(self, action: #selector(handlerNoFriends), for: .touchUpInside)
		return btn
	}()
	
	lazy var sceneFriendList: UIButton = {
		let btn = UIButton()
		btn.setTitle("只有好友畫面", for: .normal)
		btn.addTarget(self, action: #selector(handlerFriendWithoutInvited), for: .touchUpInside)
		return btn
	}()
	
	lazy var sceneFriendsWithoutInviteList: UIButton = {
		let btn = UIButton()
		btn.setTitle("好友列表畫面含邀請", for: .normal)
		btn.addTarget(self, action: #selector(handlerFriendWithInvited), for: .touchUpInside)
		return btn
	}()
	
	lazy var sceneView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 2))
		view.addSubview(sceneNoFriends)
		view.addSubview(sceneFriendList)
		view.addSubview(sceneFriendsWithoutInviteList)
		
		sceneNoFriends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: sceneNoFriends.topAnchor, trailing: view.trailingAnchor, topPadding: 8, leadingPadding: 8, bottomPadding: 8, trailingPadding: 8, width: 0, height: 0)
		sceneFriendList.anchor(top: sceneNoFriends.bottomAnchor, leading: view.leadingAnchor, bottom: sceneFriendsWithoutInviteList.topAnchor, trailing: view.trailingAnchor, topPadding: 8, leadingPadding: 8, bottomPadding: 8, trailingPadding: 8, width: 0, height: 0)
		sceneFriendsWithoutInviteList.anchor(top: sceneFriendList.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, topPadding: 8, leadingPadding: 8, bottomPadding: 8, trailingPadding: 8, width: 0, height: 0)
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	func setupUI() {
		view.backgroundColor = .systemBackground
		
		view.addSubview(sceneView)
		sceneView.center = view.center
	}
	
	@objc func handlerNoFriends() {}
	
	@objc func handlerFriendWithoutInvited() {}
	
	@objc func handlerFriendWithInvited() {}
}
