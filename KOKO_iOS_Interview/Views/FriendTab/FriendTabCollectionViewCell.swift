//
//  FriendTabCollectionView.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/11.
//

import UIKit

class FriendTabCollectionViewCell: UICollectionViewCell {
	static let Identifier: String = "FriendTabCollectionViewCell"
	
	var tab: FriendTab? {
		didSet {
			if let tab {
				titleLable.text = tab.title
				titleLable.font = tab.isSelected ? .systemFont(ofSize: 13, weight: .medium) : .systemFont(ofSize: 13, weight: .regular)
			}
		}
	}
	
	lazy var titleLable: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 13, weight: .regular)
		return label
	}()
	
	lazy var badgeLabel: UILabel = {
		let label = UILabel(frame: .init(x: 0, y: 0, width: 16, height: 16))
		label.numberOfLines = 1
		label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
		label.textColor = .white
		label.textAlignment = .center
		label.text = "1"
		return label
	}()
	
	lazy var badgeView: UIView = {
		let view = UIView()
		view.backgroundColor = .softPink
		view.layer.cornerRadius = 9
		view.clipsToBounds = true
		view.addSubview(badgeLabel)
		badgeLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
		                  topPadding: 4, leadingPadding: 4, bottomPadding: 4, trailingPadding: 4, width: 0, height: 18)
		return view
	}()
	
	lazy var underLineView: UIView = {
		let view = UIView()
		view.backgroundColor = .hotPink
		view.layer.masksToBounds = true
		view.layer.cornerRadius = 3
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}
	
	func setupUI() {
		backgroundColor = .clear
		
		addSubview(titleLable)
		addSubview(badgeView)
		addSubview(underLineView)
		titleLable.anchor(top: topAnchor, leading: leadingAnchor, bottom: underLineView.topAnchor, trailing: badgeView.leadingAnchor,
		                  topPadding: 5, leadingPadding: 0, bottomPadding: 1, trailingPadding: 0, width: 0, height: 25)
		badgeView.anchor(top: topAnchor, leading: titleLable.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
		                 topPadding: 0, leadingPadding: 3, bottomPadding: 17, trailingPadding: 5, width: 0, height: 18)
		underLineView.anchor(top: titleLable.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,
		                     topPadding: 1, leadingPadding: 2, bottomPadding: 0, trailingPadding: 2, width: 20, height: 4)
	}
	
	func configure(with friendTab: FriendTab) {
		titleLable.text = friendTab.title
		underLineView.backgroundColor = friendTab.isSelected ? .hotPink : .clear
		if let badgeCount = friendTab.badgeCount {
			badgeLabel.text = badgeCount == 0 ? "" : badgeCount > 99 ? "99+" : String(badgeCount)
			badgeView.isHidden = badgeCount <= 0
		}
	}
}
