//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Julius on 07/07/2022.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
