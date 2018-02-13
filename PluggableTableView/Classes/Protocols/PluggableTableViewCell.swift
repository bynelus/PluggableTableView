//
//  PluggableTableViewCell.swift
//  PluggableTableView
//
//  Created by Niels Koole on 13/02/2018.
//

import UIKit

public protocol PluggableTableViewCellViewModel { }

public protocol PluggableTableViewCell: AnyObject {
    var viewModel: PluggableTableViewCellViewModel? { get set }
}
