import XCTest
@testable import Base

class URLTests: ATestCase {

    func testTptpURL() {

        guard let url = URL.tptpDirectoryURL else {
            XCTFail()
            return
        }

        print(url.path)



    }





}
