//
//  Package.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/16/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import Foundation

struct Package {
    var trackingNumber: String
    var carrier: String
    var description: String?

    static let empty = Package(trackingNumber: "", carrier: "", description: nil)

    init(trackingNumber: String, carrier: String, description: String? = nil) {
        self.trackingNumber = trackingNumber
        self.carrier = carrier
        self.description = description
    }

    var isValid: Bool {
        !trackingNumber.isEmpty && !carrier.isEmpty
    }

    var errors: String {
        var errorMessages = [String]()
        if trackingNumber.isEmpty {
            errorMessages.append("Tracking Number is not present or is empty")
        }

        if carrier.isEmpty {
            errorMessages.append("Carrier is not present or is empty")
        }

        return errorMessages.joined(separator: ". ")
    }
}
