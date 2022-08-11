//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Julius on 11/08/2022.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
