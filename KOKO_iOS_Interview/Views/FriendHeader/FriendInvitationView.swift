//
//  FriendInviteView.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/15.
//

import UIKit

class FriendInvitationView: UIView {
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
		setupShadow()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}
	
	override func layoutIfNeeded() {
		super.layoutIfNeeded()
	}
	
	func setupShadow() {
		backgroundColor = .whiteTwo
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.1
		layer.shadowOffset = CGSize(width: 0, height: 4)
		layer.shadowRadius = 16
		layer.masksToBounds = false
	}
	
	func setupUI() {
		layer.cornerRadius = 6
		layer.masksToBounds = true
		
		backgroundColor = .whiteTwo
		addSubview(friendAvatorImageView)
		addSubview(friendNameLabel)
		addSubview(friendDescLabel)
		addSubview(friendAcceptButton)
		addSubview(friendRejectButton)
		
		friendAvatorImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: friendNameLabel.leadingAnchor,
		                             topPadding: 15, leadingPadding: 15, bottomPadding: 15, trailingPadding: 15, width: 40, height: 40, aspectRatio: 1)
		
		friendNameLabel.anchor(top: topAnchor, leading: friendAvatorImageView.trailingAnchor, bottom: friendDescLabel.topAnchor, trailing: nil,
		                       topPadding: 14, leadingPadding: 0, bottomPadding: 2, trailingPadding: 15, width: 0, height: 30)
		friendDescLabel.anchor(top: friendNameLabel.bottomAnchor, leading: friendAvatorImageView.trailingAnchor, bottom: bottomAnchor, trailing: nil,
		                       topPadding: 0, leadingPadding: 15, bottomPadding: 15, trailingPadding: 15, width: 0, height: 20)
		friendAcceptButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: friendRejectButton.leadingAnchor,
		                          topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 15, width: 30, height: 30)
		friendRejectButton.anchor(top: topAnchor, leading: friendAcceptButton.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
		                          topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 15, width: 30, height: 30)
	}
	
	func configure(friendInvite: FriendProfile) {
		friendNameLabel.text = friendInvite.name
	}
}

@available(iOS 17, *)
#Preview {
	FriendInvitationView()
}
