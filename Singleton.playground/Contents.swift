import UIKit

class Car {
    
    var color = "Red"
    
    static let singletonCar = Car()
    
    private init() {
    
    }
    
}

let myCar = Car.singletonCar
myCar.color = "Blue"

let youCar = Car.singletonCar
print(youCar.color)

class A {
    init() {
        print(Car.singletonCar.color)
        Car.singletonCar.color = "Brown"
    }
}

class B {
    init() {
        print(Car.singletonCar.color)
    }
}

let a = A()
let b = B()
