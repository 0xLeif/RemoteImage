# RemoteImage

RemoteImage is a Swift package that provides a SwiftUI View for loading and displaying images from a remote URL. It also caches the images for efficient reuse. Importantly, RemoteImage is designed for performance - it only loads an image once for a given URL, avoiding unnecessary network requests and optimizing app performance.

**Requirements:** iOS 16.0+ / watchOS 9.0+ / macOS 13.0+ / tvOS 16.0+ / visionOS 1.0+ | Swift 5.9+ / Xcode 15+

## **Getting Started**

To integrate RemoteImage into your Swift project, you'll need to use the Swift Package Manager (SPM). SPM makes it easy to manage Swift package dependencies. Here's what you need to do:

1. Add a package dependency to your `Package.swift` file:

```
dependencies: [
    .package(url: "https://github.com/0xLeif/RemoteImage.git", from: "1.0.0")
]
```

If you're working with an App project, open your project in Xcode. Navigate to `File > Swift Packages > Add Package Dependency...` and enter `https://github.com/0xLeif/RemoteImage.git`.

1. Next, don't forget to add RemoteImage as a target to your project. This step is necessary for both Xcode and SPM Package.swift.

After successfully adding RemoteImage as a dependency, you need to import RemoteImage into your Swift file where you want to use it. Here's a code example:

```swift
import RemoteImage
```

## Usage

### Basic Example

The basic use of RemoteImage is straightforward. You simply import the required libraries and create an instance of RemoteImage, passing the URL of the image you want to display.

```swift
import SwiftUI
import RemoteImage

struct ContentView: View {
    var body: some View {
        RemoteImage(url: "https://image_url.png")
    }
}
```

### Customized Example

For a more customized usage, you can supply additional parameters to the RemoteImage instance. In this case, we provide a placeholder view that will be displayed while the image is loading, and a content view that will be displayed once the image is available. The placeholder is a simple `ProgressView`, and the content view takes the loaded image and makes it resizable.

```swift
import SwiftUI
import RemoteImage

struct ContentView: View {
    var body: some View {
        RemoteImage(
            url: "https://image_url.png",
            placeholder: { ProgressView() },
            content: { loadedImage in
                loadedImage.resizable()
            }
        )
    }
}
```

In this example, `RemoteImage` takes a URL and two view builder closures - `placeholder` and `content`. The placeholder view is displayed while the image is loading. The content view is displayed when the image is available.

## Features

- [x]  Load remote images efficiently
- [x]  Cache loaded images for performance
- [x]  Only load an image URL request once, optimizing network utilization
- [x]  SwiftUI view for displaying remote images
- [x]  Support for placeholders while images are loading
- [x]  Fully customizable

## **Contributing**

Please open an issue or submit a pull request if you have any improvements or features you want to add.

## **Support**

If you encounter any issues or need further help, please open an issue.

## License

RemoteImage is available under the MIT license. See the LICENSE file for more info.
