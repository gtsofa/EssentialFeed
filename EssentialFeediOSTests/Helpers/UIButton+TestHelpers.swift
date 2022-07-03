//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Julius on 03/07/2022.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
