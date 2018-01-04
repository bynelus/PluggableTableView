//
//  PluggableTableHeaderFooter.swift
//  PluggableTableView
//
//  Created by Niels Koole on 04/01/2018.
//

import UIKit

public protocol PluggableTableHeaderFooter
{
    var viewType: UITableViewHeaderFooterView.Type { get }
    
    func view(from tableView: UITableView, section: Int) -> UITableViewHeaderFooterView?
    func height(for width: CGFloat) -> CGFloat
}
