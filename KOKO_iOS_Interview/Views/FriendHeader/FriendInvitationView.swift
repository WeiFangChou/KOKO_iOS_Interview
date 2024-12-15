//
//  FriendInviteView.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/15.
//

import UIKit

class FriendInviteView: UIView {
	lazy var friendAvatorImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .imgFriendsFemaleDefault
		
		return imageView
	}()
	
	lazy var friendNameLabel: UILabel = {
		let label = UILabel()
		label.text = "使用者"
		return label
	}()
	
	lazy var friendDescLabel: UILabel = {
		let label = UILabel()
		label.text = "邀請你成為好友：）"
		label.font = .systemFont(ofSize: 13, weight: .regular)
		label.textColor = .lightGrey
		return label
	}()
	
	lazy var friendAcceptButton: UIButton = {
		let btn = UIButton()
		btn.setImage(.btnFriendsAgree, for: .normal)
		return btn
	}()
	
	lazy var friendRejectButton: UIButton = {
		let btn = UIButton()
		btn.setImage(.btnFriendsDelet, for: .normal)
		return btn
	}()
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}
	
	func setupUI() {
		addSubview(friendAvatorImageView)
		addSubview(friendNameLabel)
		addSubview(friendDescLabel)
		addSubview(friendAcceptButton)
		addSubview(friendRejectButton)
		
		friendAvatorImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: friendNameLabel.leadingAnchor,
		                             topPadding: 15, leadingPadding: 15, bottomPadding: 15, trailingPadding: 15, width: 40, height: 40)
		friendNameLabel.anchor(top: topAnchor, leading: friendAvatorImageView.trailingAnchor, bottom: friendDescLabel.topAnchor, trailing: friendAcceptButton.leadingAnchor,
		                       topPadding: 14, leadingPadding: 0, bottomPadding: 2, trailingPadding: 15, width: 0, height: 0)
		friendDescLabel.anchor(top: friendNameLabel.bottomAnchor, leading: friendAvatorImageView.trailingAnchor, bottom: bottomAnchor, trailing: friendAcceptButton.leadingAnchor,
		                       topPadding: 0, leadingPadding: 15, bottomPadding: 15, trailingPadding: 15, width: 0, height: 0)
		friendAcceptButton.anchor(top: topAnchor, leading: friendNameLabel.trailingAnchor, bottom: bottomAnchor, trailing: friendRejectButton.leadingAnchor,
		                          topPadding: 20, leadingPadding: 0, bottomPadding: 20, trailingPadding: 15, width: 30, height: 30)
		friendRejectButton.anchor(top: topAnchor, leading: friendAcceptButton.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
		                          topPadding: 20, leadingPadding: 0, bottomPadding: 20, trailingPadding: 15, width: 30, height: 30)
	}
	
	func configure(friendInvite: FriendProfile) {
		friendNameLabel.text = friendInvite.name
	}
}

@available(iOS 17, *)
#Preview {
	FriendInviteView()
}
