# Go-Jek iOS Payment SDK Documentation

The iOS SDK for Go-Jek contains specialized implementation that contain one core class: `VTWidget`. This `VTWidget` is a subclass of `UITableViewCell`. So, it needs to be embedded inside a `UITableView`.


## Instantiation

### Podfile
```
source 'https://github.com/veritrans/Iossdk-gojek-bin.git'

platform :ios, '7.0'

pod 'VTGojek'
```

## Usage

#### Create widget object

```
self.widget = VTWidgetCell.init(tableView: <table object>, environment: .Production, merchantURL: <merchant server URL>, enableSaveCard: false, token: <token>)
```

#### Set `headerAuth` for request authentication

```
self.widget.setHeaderAuth(headerAuth as! [NSObject : AnyObject])
```

#### Update your `UITableView` configuration

```
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
}
    
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return widget
}
    
func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return widget.cellHeight()
}
``` 

#### Then add this lines of code to your purchase button selector

```
let itemDetail = VTItemDetail.init(itemID: <random_characters>, name: <item_name>, price: <item_price>, quantity: <item_quantity>)
let itemDetails: [VTItemDetail] = [itemDetail]
let customerDetails = VTCustomerDetails.init(firstName: <first_name>, lastName: <last_name>, email: <email>, phone: <phone_number>)
    
widget.payWithTotalPrice(<total_price>, customerDetails: customerDetails, itemDetails: itemDetails) { (result, error) in
    if (error) {
        //payment error        
    } else {
        //payment success        
    }
}

```