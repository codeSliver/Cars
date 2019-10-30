# TMDSample
App shows a list of cars fetched  from server. User can view the cars as a list or see those on the map according to the location of the car. User can toggle between map and list by using the segment control at the top.
### Features
- List of cars with driver name, car license plate and model.
- View cars on the map and get information about driver name, car license plate and model by tapping on the car pin.
- If there's no internet connectivity at the time of app start and no cars are fetched user is shown an error and when internet connectivity is restored app automatically detects the change and fetches the list of cars if there were no cars to show previously.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and debugging purposes.

### Prerequisites

You would need a macbook with XCode 11.x installed. 

### Installing

- To be able to install the build on the iPhone you will be needing Apple Developer provisioning and certifcate. You can create your Apple developer account [here](https://developer.apple.com/).
- You can create build on iOS 13.x or later simulator provided with the XCode 11.x or later.
- To run the project Navigate to the *Cars* folder on your machine where you cloned it. And open the project using *Cars.xcodeproj* file.

## User Guide to use the app
- On Launch if app is connected to the internet it automatically fetches list of cars.
- Default view when app starts is the list view.
- User can move to map view by using the segment control at the top.
- Map view shows the cars as pin on their defined location.
- In Map view user can tap the car pin to view car details about driver name, car model and license plate number.

## Technical Details

### ThirdParty
- No Third Party library is used and everything is build using native iOS components.

### App Architecture
- MVVM Architecture is used in the app.
- Network layer is based on protocol oriented design.

### Code Structure
Code is divided into following Groups
- AppDeleagte  group contains the xcode auto generated AppDelegate and SceneDelegate classes.
- Constants group contains  Constant file which stores all the constants used across the app.
- Utlities contains and AlertService protocol which is used across the app to notify users of any errors.
- Networking group contains all the files related to network layer. It contains sub groups of Reachability, NetworkHandler, NetworkRouting, HTTPHandlers, EndPoints and Services.
- Models group contains the *Car* model being used in the app.
- Source group contains the modules with their respetive view, view controllers and view models. Source group contains further subgroups named Home, List, Map and CarView.
- Home subgroup contains *CarsViewController* and *CarsViewModel*. *CarsViewController* contains two container views for displaying list and map respectively.
- List subgroup contains *ListViewController*, *ListViewModel* and *CarTableViewCell*. *ListViewController* is used to display the cars using *UITableView*.
- Map subgroup contains *MapViewController*, *MapViewModel* and *CarAnnotation*. *MapViewController* is used to display the cars using *MKMapView*.
- CarView subgroup contains *CarView*, *CarViewModel* and *CarView.xib*. *CarView* is a custom view and is used by both *CarTableViewCell* and *CarAnnotation* to display information about the car. Since information to be displayed on list and map is same for the car so this view is resued.
- Binder subgroup contains Bindable swift class. Its a generic type which provides a closure to be bind on the value so that events can be triggered on value change.

### Unit tests

Unit tests are arranged in two subgroups
- ViewModel subgroup contains tests written on ViewModels
- Networking subgroup contains tests written on Network Services

Following test cases are written:
- Cars Service test for checking if cars list fetched correctly.
- Image Service test for checking if a car image is fetched correctly.
- MapViewModelTest for testing MapViewModel with a mock json file to make sure view model behaves correctly.
- ListViewModelTest for testing ListViewModel with a mock json file to make sure view model behaves correctly.
- Url encoding test for URLEncoder to see if urls are being configured correctly.

## Built With
- XCode 11.1
- Tested on iPhone 8. (iOS 13.1.3)

## Authors

- **Arslan Faisal** - (https://github.com/arslanFaisal)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details




