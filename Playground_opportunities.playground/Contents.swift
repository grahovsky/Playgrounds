import Foundation

var str = "Hello, playground"

for count in 200...1000 {
    if count%5 != 0 {
        continue
    }
    sin(10000.0/Double(count))
}


//справочные комментарии

/**
 This func say hello to user
 - parameter name: String Name of user
 - returns: Absolutely nothing
 - throws: Error when name is array
 - authors: Grahovsky
 - bug: This is very simple function
 */
func sayHello(name: String) {
    print("hello, \(name)!")
}

sayHello(name: "Max")


