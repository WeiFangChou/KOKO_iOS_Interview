//
//  Ext+UIView.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/9.
//

import UIKit

extension UIView {
	func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil,
	            topPadding: CGFloat = 0, leadingPadding: CGFloat = 0, bottomPadding: CGFloat = 0, trailingPadding: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0, aspectRatio: CGFloat = 0)
	{
		// Auto Resize Turn Off
		translatesAutoresizingMaskIntoConstraints = false

		if let top {
			topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
		}

		if let leading {
			leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
		}

		if let bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
		}

		if let trailing {
			trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
		}

		if width != 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}

		if height != 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}

		if aspectRatio != 0 {
			widthAnchor.constraint(equalTo: heightAnchor, multiplier: width / height).isActive = true
		}
	}

	func aspectRatio(equalTo: Double) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalTo: widthAnchor, multiplier: equalTo).isActive = true
	}

	func centerX(in view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}

	func centerY(in view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
}
