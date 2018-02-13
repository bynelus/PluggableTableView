//
//  PluggableTableViewModel.swift
//  PluggableTableView
//
//  Created by Niels Koole on 12/10/2017.
//  Copyright © 2018 Niels Koole. All rights reserved.
//

import UIKit

public protocol PluggableTableViewModel {
    var cellType: UITableViewCell.Type { get }
    func height(for width: CGFloat) -> CGFloat?
}

public extension PluggableTableViewModel {
    public func height(for width: CGFloat) -> CGFloat? {
        return nil
    }
}
