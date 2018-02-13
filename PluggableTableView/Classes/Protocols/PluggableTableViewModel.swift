//
//  PluggableTableViewModel.swift
//  PluggableTableView
//
//  Created by Niels Koole on 12/10/2017.
//  Copyright © 2018 Niels Koole. All rights reserved.
//

import UIKit

public class PluggableTableViewModel {
    var cellType: UITableViewCell.Type = UITableViewCell.self
    
    func height(for width: CGFloat) -> CGFloat? {
        return nil
    }
}
