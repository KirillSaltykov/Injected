/*
 MIT License

 Copyright (c) 2020 Kirill Saltykov

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

public final class Injector {
    public static var shared = Injector()
    
    private var factories: [String: () -> Any] = [:]
    
    public func add<T: Any>(_ factory: @escaping () -> T) {
        self.factories[String(describing: T.self)] = factory
    }
    
    public func resolve<T: Any>() -> T {
        guard let component: T = factories[String(describing: T.self)]?() as? T else {
            fatalError("Can not resolve dependency: \(T.self)")
        }
        
        return component
    }
}


@propertyWrapper
public struct Injected<Component> {
    public var wrappedValue: Component {
        Injector.shared.resolve()
    }
    
    public init() {}
}
