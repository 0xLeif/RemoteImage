import AppState
import Network
import SwiftUI

extension Application {
    /// A dependency that provides the RemoteImageStore
    internal var remoteImageStore: Dependency<RemoteImageStore> {
        dependency(RemoteImageStore())
    }

    /// A dependency that provides the Network
    public var remoteImageNetwork: Dependency<Network> {
        dependency(Network())
    }

    /// A state to store remote images with their respective URLs
    public var remoteImages: State<[URL: Image]> {
        state(initial: [:])
    }

    /// The default dependencies to load when using RemoteImage
    @discardableResult
    public static func loadRemoteImageDependencies() -> Application.Type {
        load(dependency: \.remoteImageStore)
        load(dependency: \.remoteImageNetwork)

        return Application.self
    }
}
