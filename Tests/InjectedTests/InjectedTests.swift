import XCTest
@testable import Injected

struct Engine {
    let power: Float
}

struct Car {
    @Injected var engine: Engine
}

final class InjectedTests: XCTestCase {
    
    func testBasicResolving() {
        let container = Injector()
        
        container.add({ "Test" as String })
        
        XCTAssertEqual(container.resolve(), "Test")
    }
    
    func testInjectingIntoProperty() {
        let container = Injector()
        
        container.add({ Engine(power: 88.7) as Engine })
        container.add({ Car() })
        
        Injector.shared = container
        
        let sut: Car = container.resolve()
        
        XCTAssertNotNil(sut.engine)
        XCTAssertEqual(sut.engine.power, 88.7)
    }

    static var allTests = [
        ("testBasicResolving", testBasicResolving),
        ("testInjectingIntoProperty", testInjectingIntoProperty)
    ]
}
