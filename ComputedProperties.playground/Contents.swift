import Foundation

let pizzaInInches: Int = 10

var numberOfSlices: Int {
    get {
        return pizzaInInches - 4
    }
}

print(numberOfSlices)


