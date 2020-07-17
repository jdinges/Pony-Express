//
//  Package.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/16/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import Foundation

final class Package {
    let trackingNumber: String
    let carrier: String
    let description: String

    static let empty = Package(trackingNumber: "", carrier: "", description: "")

    init(trackingNumber: String, carrier: String, description: String) {
        self.trackingNumber = trackingNumber
        self.carrier = carrier
        self.description = description
    }
}
