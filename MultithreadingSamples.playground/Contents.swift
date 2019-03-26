import Foundation
import UIKit
import PlaygroundSupport

var str = "Hello, playground"

class SwiftTest {
    private let queue = DispatchQueue(label: "SwiftTest")
    struct TestStruct {
        var i: Int
        var y: Int
    }
    let testStruct = TestStruct(i: 10, y: 100)
    func test() {
        queue.async {
            print(self.testStruct.i)
        }
        queue.async {
            print(self.testStruct.y)
        }
    }
}

let swiftTest = SwiftTest()
swiftTest.test()

class CollectionTest {
    private let queue = DispatchQueue(label: "CollectionTest")
    private let cache = NSCache<NSString, NSNumber>()
    func test() {
        queue.async {
            let number = NSNumber(integerLiteral: 1)
            let key = NSString(string: "test")
            self.cache.setObject(number, forKey: key)
        }
        queue.async {
            let number = NSNumber(integerLiteral: 2)
            let key = NSString(string: "test")
            self.cache.setObject(number, forKey: key)
        }
        queue.async {
            let number = NSNumber(integerLiteral: 3)
            let key = NSString(string: "test")
            self.cache.setObject(number, forKey: key)
        }
    }
}

let collectionTest = CollectionTest()
collectionTest.test()

class BackgroundDrawingView: UIView {
    private let queue = DispatchQueue(label: "BackgroundDrawingView", attributes: .concurrent)
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawBackground(rect: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func drawBackground(rect: CGRect) {
        queue.async {
            let test = "test"
            let attributes = [NSAttributedStringKey.foregroundColor: UIColor.green,
                              NSAttributedStringKey.kern: 20,
                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)
                ] as [NSAttributedStringKey : Any]
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
            test.draw(in: rect, withAttributes: attributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            DispatchQueue.main.async {
                self.layer.contents = image?.cgImage
            }
        }
    }
}

let frame = CGRect(x: 10, y: 10, width: 10, height: 10)
let backgroundDrawingView = BackgroundDrawingView(frame: frame)





