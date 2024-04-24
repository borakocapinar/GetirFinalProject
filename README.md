# Getir Lite

## About the Project
This project is the final project of the Getir iOS Swift Bootcamp organized in cooperation with [Patika.dev](https://www.patika.dev) and [Getir](https://getir.com). In the project, which is a lite version of the Getir application, certain features of the Getir application were imitated.

The aim of the project is to develop an application that allows the user to view the products in the mock api response in a list and add/remove any of them to/out of the cart.

![Screens](Screenshots/MainPages.png)
## Key Features


### Product Listing
- **Description**: The app fetches and displays product data from mock APIs, featuring a horizontal scrollable list for products and a vertical list for product details. Users can navigate to detailed product views by clicking on items in the list.

<br>

![Product Listing](GIFS/ProductListing.gif)

### Product Details
- **Description**: Displays detailed information including the product's image, name, price, description, and current amount in the cart. Users can update product quantities using a stepper control and save changes.

<br>

![Product Details](GIFS/ProductDetails.gif)

### Shopping Cart
- **Description**: Users can view all items in their cart with individual counts. Features include updating quantities, checking out with a success message that shows the total cart amount, and resetting local data post-checkout. Navigation to the cart screen is disabled if the cart is empty.

<br>

![Shopping Cart](GIFS/Cart.gif)
## Tech Stack
Detail the technologies and tools used in the development of your app.
- Xcode Version: 15.3
- Language: Swift 5
- iOS Version: iOS 14.0
- UI Framework: UIKit

## Third Party Dependencies

- [Moya](https://github.com/Moya/Moya) for network requests
- [SnapKit](https://github.com/SnapKit/SnapKit) for programmatic UI auto layout
- [Kingfisher](https://github.com/onevcat/Kingfisher) for image loading

