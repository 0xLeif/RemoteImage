import AppState
import Network
import SwiftUI

/// An actor that acts as a store for remote images.
actor RemoteImageStore: ObservableObject {

    /// Enum for store error cases.
    enum StoreError: LocalizedError {
        case waiting(URL)
        case loaded(URL)

        var errorDescription: String? {
            switch self {
            case .waiting(let url): "Waiting for existing load request for url '\(url.absoluteString)'"
            case .loaded(let url):  "Already loaded image for url '\(url.absoluteString)'"
            }
        }
    }

    /// Network dependency.
    @AppDependency(\.remoteImageNetwork) private var network: Network

    /// Images currently available in the store.
    @MainActor
    @AppState(\.remoteImages) private var images: [URL: Image]

    /// Images currently being loaded.
    private var loadingImages: Set<URL> = []

    /**
     Retrieves image from the store.

     - Parameter url: The URL of the image.

     - Returns: The image if it exists in the store, otherwise nil.
     */
    @MainActor
    func image(url: URL?) -> Image? {
        guard let url else { return nil }

        return images[url]
    }

    /**
     Loads image from the URL and stores it.

     - Parameter url: The URL of the image.

     - Returns: The loaded image if successful, otherwise nil.

     - Throws: `StoreError.waiting(url)` if the URL is already being loaded, `StoreError.loaded(url)` if the image is already loaded.
     */
    func load(url: URL) async throws -> Image? {
        guard loadingImages.contains(url) == false else {
            throw StoreError.waiting(url)
        }

        guard await images.contains(url) == false else {
            throw StoreError.loaded(url)
        }

        loadingImages.insert(url)

        let dataResponse = try await network.get(url: url)

        guard let data = dataResponse.data else {
            loadingImages.remove(url)
            return nil
        }

        var loadedImage: Image?

        #if os(macOS)
        if let nsImage = NSImage(data: data) {
            loadedImage = Image(nsImage: nsImage)
        }
        #else
        if let uiImage = UIImage(data: data) {
            loadedImage = Image(uiImage: uiImage)
        }
        #endif

        loadingImages.remove(url)

        await update(url: url, image: loadedImage)

        return loadedImage
    }

    /**
     Updates the image store.

     - Parameters:
       - url: The URL of the image.
       - image: The loaded image.
     */
    @MainActor
    private func update(url: URL, image: Image?) {
        images[url] = image
    }
}
