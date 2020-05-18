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

public enum Scope {
    case unique, singleton
}

public final class Injector {
    public static var shared = Injector()
    
    private var factories: [String: () -> Any] = [:]
    private var singletons: [String: Any] = [:]
    private var metadata: [String: Scope] = [:]
    
    public init() {  }
    
    public func add<T>(scope: Scope = .unique, _ factory: @escaping () -> T) {
        let key = String(describing: T.self)
        
        switch scope {
        case .unique:
            self.factories[key] = factory
        case .singleton:
            self.singletons[key] = factory()
        }
        
        self.metadata[key] = scope
    }
    
    public func resolve<T: Any>() -> T {
        let key = String(describing: T.self)
        
        guard let meta = self.metadata[key] else {
            fatalError("Empty metadata: \(T.self)")
        }
        
        switch meta {
        case .unique:
            guard let instance = self.factories[key]?() as? T else {
                fatalError("Can not create \(T.self)")
            }
            
            return instance
        case .singleton:
            guard let instance = self.singletons[key] as? T else {
                fatalError("Can not find \(T.self)")
            }
            
            return instance
        }
    }
}


@propertyWrapper
public struct Injected<Component> {
    public var wrappedValue: Component {
        Injector.shared.resolve()
    }
    
    public init() { }
}
