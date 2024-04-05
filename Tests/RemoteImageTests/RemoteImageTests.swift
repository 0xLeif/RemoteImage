import AppState
import Waiter
import XCTest
@testable import RemoteImage

final class RemoteImageTests: XCTestCase {
    func testViewModel() async throws {
        let exampleImageURL = "https://avatars.githubusercontent.com/u/8268288?v=4"

        let viewModel = RemoteImageViewModel()

        XCTAssertNil(viewModel.image)

        viewModel.load(url: URL(string: exampleImageURL))

        try await Waiter.wait(on: viewModel, for: \.image, expecting: { $0 != nil })

        XCTAssertNotNil(viewModel.image)
    }
}
