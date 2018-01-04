//
//  PluggableTableSection.swift
//  PluggableTableView
//
//  Created by Niels Koole on 12/10/2017.
//  Copyright © 2018 Niels Koole. All rights reserved.
//

import Foundation

public protocol PluggableTableSection
{
    var header: PluggableTableHeaderFooter? { get }
    var viewModels: [PluggableTableViewModel] { get }
    var footer: PluggableTableHeaderFooter? { get }
}
