import UIKit

class Person {
    var name: String
    var secondName: String
    class var clasProperty: Bool {return true}
    
    var acessLevel = 0 {

        willSet(newValue) {
            print("newValue \(newValue)")
        }

        didSet {
            print("oldValue \(oldValue)")
        }

    }
    
    var fullName: String {
        set(anotherNewValue) {
            let array = anotherNewValue.components(separatedBy: " ")
            name = array[0]
            secondName = array[1]
        }
        get {
            return name + " " + secondName
        }
    }
    
    init(name: String, secondName: String) {
        self.name = name
        self.secondName = secondName
    }
    
}

indirect enum Device {
    case iPad(color: String), iPhone, phone(Device, Device)
    var year: Int {
        switch self {
        case .iPhone: return 2007
        case .iPad(let color) where color == "black":return 2020
        case .iPad: return 2010
        case .phone(.iPad, .iPhone): return 2019
        default: return 0
        }
    }
}

enum Character {
     enum Weapon: Int {
        case sword = 4, wand = 1
        var damage: Int {
            return rawValue * 10
        }
    }
    enum CharacterType {
        case knight, mage
    }
}

let year = Device.iPad(color: "black").year
let year2 = Device.iPad(color: "white").year

let person1 = Person(name: "Kostya", secondName: "Grahovsky")
person1.fullName = "Konstantin Grahovsky"

person1.acessLevel = 1

person1.acessLevel = 5

let charDamage = Character.Weapon.sword.damage


//Базовые операторы
var name: String?
//name = "Ivan"
let myname = name ?? "Vanya"

let ten = 10

let tten  = (ten > 10 ? 10 : 11)

//операторы диапазона
1...10
1..<10

let arrayOne = Array<Int>()
let arrayTwo = [Int]()
var arrayThree: [Int] = []
let arrayFour = [1, 2, 3, 4]
let arrayFive = [Int](repeating: 10, count: 6)

arrayThree += arrayFive
arrayThree[1...3] = [15]
arrayThree
arrayThree.count
arrayThree.append(100)
arrayThree.removeFirst()

arrayThree


