# PluggableTableView

[![CI Status](http://img.shields.io/travis/bynelus/PluggableTableView.svg?style=flat)](https://travis-ci.org/bynelus/PluggableTableView)
[![Version](https://img.shields.io/cocoapods/v/PluggableTableView.svg?style=flat)](http://cocoapods.org/pods/PluggableTableView)
[![License](https://img.shields.io/cocoapods/l/PluggableTableView.svg?style=flat)](http://cocoapods.org/pods/PluggableTableView)
[![Platform](https://img.shields.io/cocoapods/p/PluggableTableView.svg?style=flat)](http://cocoapods.org/pods/PluggableTableView)
[![Twitter](https://img.shields.io/twitter/follow/nielskoole.svg?style=social&label=Follow)](http://twitter.com/nielskoole)

- [Installation](#installation)
- [Usage](#usage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 4.0

## Installation

PluggableTableView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PluggableTableView'
```

## Summary

Showing a list is something you can see in almost every app. PluggableTableView becomes handy if you want to show a simple list that should be extendable.
You can add all kinds of cells, headers and footers by just providing a new view model. View Models seperates business logic from the controller and can easily be tested. This configuration is open for extendability and close for modification. 

## Features

- [x] Support view models for a table view.
- [x] Automatic registration of cell types and header / footer views.
- [x] Support auto sizing cells and non-auto sizing cells.
- [x] Support xib cells.
- [ ] Support non-xib cells.

## Usage

### Setup the view

```swift
import PluggableTableView

class ViewController: UIViewController
{
  @IBOutlet weak var tableView: PluggableTableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.pluggableDataSource = self
  }
}

extension ViewController: PluggableTableViewDataSource
{
  func pluggableSections() -> [PluggableTableSection] {
    return []
  }
}
```

### Create view models

Create a section view model that specifies which header / footer and cells to show.
```swift
class DefaultSection: PluggableTableSection
{
  let header: PluggableTableHeaderFooter?
  let viewModels: [PluggableTableViewModel]
  let footer: PluggableTableHeaderFooter?
    
  init(viewModels: [PluggableTableViewModel], header: PluggableTableHeaderFooter? = nil, footer: PluggableTableHeaderFooter? = nil) {
    self.viewModels = viewModels
    self.header = header
    self.footer = footer
  }
}
```

Then you only need to specify your cell view model, which can be literally anything. Below just an example.
```swift
class CellTitleViewModel: PluggableTableViewModel
{
  typealias C = YourTitleCell

  let model: Model // The model you want to map to this view model.
  var cellType: UITableViewCell.Type = C.self
    
  init(model: Model) {
    self.model = model
  }
    
  func cell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as! C
    cell.title = "\(model.title) \(model.something)"
    return cell
  }
    
  func height(for width: CGFloat) -> CGFloat { return 0 }
}
```

### Provide data to table view

```swift
import PluggableTableView

class ViewController: UIViewController
{
  // Configure the view..
}

extension ViewController: PluggableTableViewDataSource
{
  func pluggableSections() -> [PluggableTableSection] {
    let viewModels = models.map({ CellTitleViewModel(model: $0) })
    let singleSection = DefaultSection(viewModels: viewModels) 
    return [singleSection]
  }
}
```

## Author

NielsKoole, me@nielskoole.nl

## License

PluggableTableView is available under the MIT license. See the LICENSE file for more info.
