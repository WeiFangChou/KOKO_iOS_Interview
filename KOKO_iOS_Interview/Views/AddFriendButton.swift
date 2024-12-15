//
//  AddFriendButton.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/13.
//

import UIKit

class AddFriendButton: UIButton {
	lazy var buttonIconImageView: UIImageView = {
		let view = UIImageView()
		view.image = .icAddFriendWhite
		view.contentMode = .scaleAspectFit
		view.clipsToBounds = true
		
		return view
	}()
	
	lazy var gradientLayer: CAGradientLayer = {
		let l = CAGradientLayer()
		l.frame = self.bounds
		l.colors = [UIColor.frogGreen.cgColor, UIColor.booger.cgColor]
		l.startPoint = CGPoint(x: 0, y: 0.5)
		l.endPoint = CGPoint(x: 1, y: 0.5)
		l.cornerRadius = 16
		layer.insertSublayer(l, at: 0)
		return l
	}()
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}

	func setupUI() {
		addSubview(buttonIconImageView)
		buttonIconImageView.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, topPadding: 8, leadingPadding: 0, bottomPadding: 8, trailingPadding: 8, width: 24, height: 24)
	}
}
