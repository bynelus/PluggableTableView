//
//  PluggableTableViewCell.swift
//  PluggableTableView
//
//  Created by Niels Koole on 13/02/2018.
//

import UIKit

public class PluggableTableViewCell<VM: PluggableTableViewModel>: UITableViewCell {
    var viewModel: VM?
}
