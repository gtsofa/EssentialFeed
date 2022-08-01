//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Julius on 01/08/2022.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
