# Go-Jek iOS Payment SDK Documentation

The iOS SDK for Go-Jek contains specialized implementation that contain one core class: `VTWidget`. This `VTWidget` is a subclass of `UITableViewCell`. So, it needs to be embedded inside a `UITableView`.


## Release Notes 1.6.13
* Full screen dialog for 3DS
* Add close button in dialog
* Change sandbox clientkey to go-jek's clientkey


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
self.widget = VTWidgetCell.init(tableView: <table object>, environment: <.Production / .Sandbox>, merchantURL: <merchant server URL>, enableSaveCard: false, token: <token>)
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
let itemDetail = VTItemDetail.init(itemID: <random_alphanumeric>, name: <item_name>, price: <item_price>, quantity: <item_quantity>)
let itemDetails: [VTItemDetail] = [itemDetail]
let customerDetails = VTCustomerDetails.init(firstName: <first_name>, lastName: <last_name>, email: <email>, phone: <phone_number>)    
let transactionDetails = VTTransactionDetails.init(orderID: <random_alphanumeric>, andGrossAmount: <total_price_amount>)
        
widget.payWithTransactionDetails(transactionDetails, customerDetails: customerDetails, itemDetails: itemDetails, tokenCompletion: { (token, error) in
    //transaction token retrieved
}) { (result, error) in
    //transaction finished
}

```
