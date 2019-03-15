import Foundation

var pizzaInInches: Int = 16 {
    willSet {
        print(pizzaInInches)
        print(newValue)
    }
    didSet {
        print(pizzaInInches)
        print(oldValue)
        
        if pizzaInInches > 18 {
            print("Invalid size specified, pizzaInInches set to 18.")
            pizzaInInches = 18
        }
        
    }
    
}
var numberOfPeople: Int = 12
let slicesPerPerson: Int = 4

var numberOfSlices: Int {
    get {
        return pizzaInInches - 4
    }
    set {
        print("numberOfSlices now has a new value which is \(newValue)")
    }
}

var numberOfPizza: Int {
    get {
        let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
        return numberOfPeople / numberOfPeopleFedPerPizza
    }
    set {
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices / slicesPerPerson
    }
}

print(numberOfPizza)

numberOfPizza = 8

print(numberOfPeople)

pizzaInInches = 33

print(pizzaInInches)

