//
//  FriendTableViewCell.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/10.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
	static let Identifier: String = "FriendTableViewCell"
	
	var friendProfile: FriendProfile? {
		didSet {
			starImageView.isHidden = friendProfile?.isTop == "1"
			friendAvatorImageView.image = .imgFriendsFemaleDefault
			friendNameLabel.text = friendProfile?.name
			moreButton.isHidden = friendProfile?.status == .inviting
			inviteButton.isHidden = friendProfile?.status != .inviting
		}
	}
	
	lazy var starImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .icFriendsStar
		return imageView
	}()
	
	lazy var friendAvatorImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .imgFriendsFemaleDefault
		return imageView
	}()
	
	lazy var friendNameLabel: UILabel = {
		let label = UILabel()
		label.text = "使用者"
		label.textColor = .greyishBrown
		label.font = .systemFont(ofSize: 16, weight: .regular)
		return label
	}()
	
	lazy var transformButton: UIButton = {
		let btn = UIButton()
		btn.setTitle("轉帳", for: .normal)
		btn.tintColor = .hotPink
		btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
		btn.setTitleColor(.hotPink, for: .normal)
		btn.layer.borderWidth = 1.2
		btn.layer.borderColor = UIColor.hotPink.cgColor
		btn.layer.masksToBounds = true
		return btn
	}()
	
	lazy var inviteButton: UIButton = {
		let btn = UIButton()
		btn.setTitle("邀請中", for: .normal)
		btn.tintColor = .lightGrey
		btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
		btn.setTitleColor(.lightGrey, for: .normal)
		btn.layer.borderWidth = 1.2
		btn.layer.borderColor = UIColor.lightGrey.cgColor
		btn.layer.masksToBounds = true
		return btn
	}()
	
	lazy var moreButton: UIButton = {
		let btn = UIButton()
		btn.setImage(.init(systemName: "ellipsis"), for: .normal)
		btn.tintColor = .systemGray
		return btn
	}()
	
	init(friendProfile: FriendProfile) {
		self.friendProfile = friendProfile
		super.init(style: .default, reuseIdentifier: nil)
		setupUI()
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}
	
	func setupUI() {
		addSubview(starImageView)
		addSubview(friendAvatorImageView)
		addSubview(friendNameLabel)
		addSubview(transformButton)
		addSubview(inviteButton)
		addSubview(moreButton)

		starImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: friendAvatorImageView.leadingAnchor,
		                     topPadding: 23, leadingPadding: 10, bottomPadding: 23, trailingPadding: 6, width: 14, height: 14)
		friendAvatorImageView.anchor(top: topAnchor, leading: starImageView.trailingAnchor, bottom: bottomAnchor, trailing: friendNameLabel.leadingAnchor,
		                             topPadding: 10, leadingPadding: 0, bottomPadding: 10, trailingPadding: 15, width: 40, height: 40)
		friendNameLabel.anchor(top: topAnchor, leading: friendAvatorImageView.trailingAnchor, bottom: bottomAnchor, trailing: transformButton.leadingAnchor, topPadding: 19, leadingPadding: 15, bottomPadding: 19, trailingPadding: 0, width: 190, height: 30)
		transformButton.anchor(top: topAnchor, leading: friendNameLabel.trailingAnchor, bottom: bottomAnchor, trailing: inviteButton.leadingAnchor,
		                       topPadding: 18, leadingPadding: 0, bottomPadding: 18, trailingPadding: 10, width: 47, height: 0)
		inviteButton.anchor(top: topAnchor, leading: transformButton.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
		                    topPadding: 18, leadingPadding: 15, bottomPadding: 18, trailingPadding: 0, width: 0, height: 0)
		moreButton.isHidden = true
		moreButton.anchor(top: topAnchor, leading: transformButton.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
		                  topPadding: 18, leadingPadding: 15, bottomPadding: 18, trailingPadding: 15, width: 30, height: 0)
	}
	
	func configure(friendProfile: FriendProfile) {
		self.friendProfile = friendProfile
	}
}

@available(iOS 17, *)
#Preview {
	FriendTableViewCell(friendProfile: FriendProfile(name: "王小明", status: .accepted, isTop: "1", fid: "001", updateDate: .now))
}
