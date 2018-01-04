//
//  PluggableTableViewDataSource.swift
//  PluggableTableView
//
//  Created by Niels Koole on 12/10/2017.
//  Copyright © 2018 Niels Koole. All rights reserved.
//

import UIKit

public protocol PluggableTableViewDataSource
{
    func pluggableSections() -> [PluggableTableSection]
}
