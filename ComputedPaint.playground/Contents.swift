import Foundation

var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int {
    get {
        let area = width * height
        let areaCoveredPerBucket: Float = 1.5
        let numberOfBuckets = area / areaCoveredPerBucket
        
        //return Int(numberOfBuckets.rounded(.up))
        let roundedBuckets = ceilf(numberOfBuckets)
        return Int(roundedBuckets)
    }
    set {
        let areaCoveredPerBucket: Float = 1.5
        let areaCanCover: Float = areaCoveredPerBucket * Float(newValue)
        print("This amount of paint can cover an area of \(areaCanCover)")
    }
}

print(bucketsOfPaint)

bucketsOfPaint = 5
