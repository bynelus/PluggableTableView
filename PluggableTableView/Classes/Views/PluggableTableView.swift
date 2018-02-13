//
//  PluggableTableView.swift
//  PluggableTableView
//
//  Created by Niels Koole on 12/10/2017.
//  Copyright © 2018 Niels Koole. All rights reserved.
//

import UIKit

public class PluggableTableView: UITableView
{
    public var autoSizingEnabled: Bool = true
    private var sections: [PluggableTableSection] = []
    private var cellTypeRegistrations: [UITableViewCell.Type] = []
    private var headerFooterTypeRegistrations: [UITableViewHeaderFooterView.Type] = []
    
    public var pluggableDataSource: PluggableTableViewDataSource? {
        didSet { reloadData() }
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        localInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        localInit()
    }
    
    private func localInit() {
        dataSource = self
        delegate = self
        estimatedRowHeight = 50.0
        separatorStyle = .none
        register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
    
    public override func reloadData() {
        sections = pluggableDataSource?.pluggableSections() ?? []
        updateCellTypeRegistrations()
        updateHeaderFooterTypeRegistrations()
        super.reloadData()
    }
    
    private func updateHeaderFooterTypeRegistrations() {
        let newHeaderViewTypes = sections.flatMap({ $0.header?.viewType })
        let newFooterViewTypes = sections.flatMap({ $0.footer?.viewType })
        let newViewTypes = newHeaderViewTypes + newFooterViewTypes
        let unregisteredTypes = newViewTypes.filter({ type in
            return headerFooterTypeRegistrations.index(where: { $0 == type }) == nil
        })

        for type in unregisteredTypes {
            guard headerFooterTypeRegistrations.index(where: { $0 == type }) == nil else { continue }
            let identifier = type.reuseIdentifier
            register(UINib(nibName: identifier, bundle: Bundle(for: type)), forHeaderFooterViewReuseIdentifier: identifier)
            headerFooterTypeRegistrations.append(type)
        }
    }
    
    private func updateCellTypeRegistrations() {
        let currentSectionItemCellTypes = sections.flatMap({ $0.viewModels }).map({ $0.cellType })
        let unregisteredCellTypes = currentSectionItemCellTypes.filter({ cellType in
            return cellTypeRegistrations.index(where: { $0 == cellType }) == nil
        })
        
        for cellType in unregisteredCellTypes {
            guard cellTypeRegistrations.index(where: { $0 == cellType }) == nil else { continue }
            
            let identifier = cellType.reuseIdentifier
            register(UINib(nibName: identifier, bundle: Bundle(for: cellType)), forCellReuseIdentifier: identifier)
            cellTypeRegistrations.append(cellType)
        }
    }
}

extension PluggableTableView: UITableViewDataSource
{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !autoSizingEnabled else { return UITableViewAutomaticDimension }
        guard let height = sections[indexPath.section].viewModels[indexPath.row].height(for: tableView.bounds.size.width) else { return 0 }
        return height
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = sections[indexPath.section].viewModels[indexPath.item]
        let identifier = viewModel.cellType.reuseIdentifier
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PluggableTableViewCell<PluggableTableViewModel> {
            cell.viewModel = viewModel
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
    }
}

extension PluggableTableView: UITableViewDelegate
{
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = sections[section].header?.view(from: tableView, section: section) else { return nil }
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = sections[section].header else { return 0 }
        return autoSizingEnabled ? UITableViewAutomaticDimension : (header.height(for: tableView.bounds.size.width) ?? 0.0)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = sections[section].footer?.view(from: tableView, section: section) else { return nil }
        return footerView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footer = sections[section].footer else { return 0 }
        return autoSizingEnabled ? UITableViewAutomaticDimension : (footer.height(for: tableView.bounds.size.width) ?? 0.0)
    }
}
