//
//  Ext+DateFormatter.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/12.
//

import Foundation

extension DateFormatter {
	static let yearMonthDay: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyyMMdd"
		return dateFormatter
	}()

	static let yearMonthDayWithSlash: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy/MM/dd"
		return dateFormatter
	}()
}
