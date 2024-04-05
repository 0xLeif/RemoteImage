import AppState
import Combine
import SwiftUI

class RemoteImageViewModel: ObservableObject {
    @AppDependency(\.remoteImageStore) private var imageStore: RemoteImageStore

    /// The image to be used by the RemoteImage
    @Published var image: Image?

    /// A cancellable instance that stores a reference to the imageStoreWillChange publisher
    private var imageStoreWillChange: AnyCancellable?

    init() {
        consume(object: imageStore)
    }

    deinit { imageStoreWillChange?.cancel() }

    /**
     This function loads an image from a URL and stores it.

     - Parameter url: The URL from where the image will be loaded.
     */
    func load(url: URL?) {
        guard let url else { return }
        
        Task {
            if let cachedImage = await imageStore.image(url: url) {
                await MainActor.run {
                    image = cachedImage
                }
                return
            }

            guard let loadedImage = try await imageStore.load(url: url) else {
                return
            }

            await MainActor.run {
                image = loadedImage
            }
        }
    }

    /// Consumes changes in the provided ObservableObject and sends updates before the object will change.
    ///
    /// - Parameter object: The ObservableObject to observe
    private func consume<Object: ObservableObject>(
        object: Object
    ) where ObjectWillChangePublisher == ObservableObjectPublisher {
        imageStoreWillChange = object.objectWillChange.sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            }
        )
    }
}
