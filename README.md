# Inejcted
[![codebeat badge](https://codebeat.co/badges/5528960b-daa2-474f-8cf3-38e8d20a1a60)](https://codebeat.co/projects/github-com-kirillsaltykov-injected-master)

## How to use?

1. Use current `Injector.shared` or create new `Injector`
2. Register dependencies using `Injector.add()`
3. Use `@Injected` wrapper

## Example

```Swift
struct Engine {
    let power: Float
}

struct Car {
    @Injected var engine: Engine
}

let container = Injector()
container.add({ Engine(power: 88.7) as Engine })
container.add({ Car() })

Injector.shared = container

let car: Car = container.resolve()
car.engine.power // 88.7
```


For singletons you can use `Scope`:
```Swift
container.add(scope: .singletone, { Engine(power: 88.7) as Engine })
```
