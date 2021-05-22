//
//  DateFormatter+ext.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 22.05.2021.
//

import Foundation

extension DateFormatter{
    
    static let ruFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH.mm"
        dateFormatter.timeZone = .current
        return dateFormatter
    }()
}
