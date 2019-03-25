import Foundation


//operation
class BlockOperationTest {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        
        let blockOperation = BlockOperation {
            print("BlockOperationTest test")
        }
        
        // Operation status:
        // isReady
        // isAsynchronous
        // isExecuting
        // isFinished
        // isCancelled
        
        operationQueue.addOperation(blockOperation)
        
    }
    
}

let test = BlockOperationTest()
test.test()

class OperationKVOTest: NSObject {
    
    func test() {
        
        let operation = Operation()
        
        operation.addObserver(self, forKeyPath: "isCancelled", options: NSKeyValueObservingOptions.new
            , context: nil)
        
        func observeValue(forKeyPath keyPath: String?, of: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutablePointer<Any>?) {
            
            if keyPath == "isCanceled" {
                print("OperationKVOTest isCanceled")
            }
            
        }
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation)
        
    }
    
}

let operationKVOTest = OperationKVOTest()
operationKVOTest.test()

// Operation queue

class OperationTest2 {
    
    private let operationQueue = OperationQueue()
    
    class OperationA: Operation {
        override func main() {
            print("operationKVOTest test OperationA")
        }
    }
    
    func test() {
        operationQueue.addOperation {
            print("operationKVOTest test operation queue")
        }
        let operationA = OperationA()
        operationQueue.addOperation(operationA)
    }
    
    
}

let operationTest2 = OperationTest2()
operationTest2.test()

class OperationCountTest {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        operationQueue.maxConcurrentOperationCount = 1 // change to 3
        operationQueue.addOperation {
            //sleep(1)
            print("OperationCountTest test1")
        }
        operationQueue.addOperation {
            //sleep(1)
            print("OperationCountTest test2")
        }
        operationQueue.addOperation {
            //sleep(1)
            print("OperationCountTest test3")
        }
    
    }
    
}

let operationCountTest = OperationCountTest()
operationCountTest.test()

class CancelTest {
    
    private let operationQueue = OperationQueue()
    
    class OperationCancelTest: Operation {
        
        override func main() {
            if isCancelled {
                return
            }
            sleep(1)
            if isCancelled {
                return
            }
            print("CancelTest test")
        }
    }
    
    func test() {
        let cancelOperation = OperationCancelTest()
        operationQueue.addOperation(cancelOperation)
        cancelOperation.cancel()
    }
}


// sample
//let operationCancelTest = CancelTest()
//operationCancelTest.test()
//
//let operationQueueCancel = OperationQueue()
//let operation = BlockOperation { print("start"); sleep(2); print("end") }
//
//operationQueueCancel.addOperation(operation)
//sleep(1);
//operation.cancel()
///

// dependencies sample
//let operationQueue3 = OperationQueue()
//
//let operation1 = BlockOperation { print("dependencies test1") }
//let operation2 = BlockOperation { print("dependencies test2") }
//let operation3 = BlockOperation { print("dependencies test3") }
//
//operation3.addDependency(operation2)
//
//operationQueue3.addOperations([operation1, operation2, operation3], waitUntilFinished: false)

// waitUntilAllOperationsAreFinished
class WaitOperationsTest {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        
        operationQueue.addOperation {
            //sleep(1)
            print("waitUntil test1")
        }
        operationQueue.addOperation {
            //sleep(2)
            print("waitUntil test2")
        }
        operationQueue.waitUntilAllOperationsAreFinished()
    
    }
    
}

//let waitOperationsTest = WaitOperationsTest()
//waitOperationsTest.test()
//
//let operationQueue4 = OperationQueue()
//operationQueue4.addOperation {
//    print("test1")
//}
//
//operationQueue4.addOperation {
//    print("test2")
//}
//
//operationQueue4.waittUntilAllOperationsAreFinished()
//
//operationQueue4.addOperation {
//    print("test3")
//}

class CompletionBlockTest {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        
        let operation = BlockOperation {
            print("CompletionBlockTest test")
        }
        operation.completionBlock = {
            print("CompletionBlockTest finish")
        }
        operationQueue.addOperation(operation)
        
    }
    
}

let completionBlockTest = CompletionBlockTest()
completionBlockTest.test()

// sample
//let operationQueue5 = OperationQueue()
//
//let operation5 = BlockOperation {
//    print("test")
//    sleep(2)
//}
//
//operation5.completionBlock = {
//    print("finish")
//}
//
//operationQueue5.addOperation(operation5)
//sleep(1)
//operation5.cancel()

class OperationSuspensedTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        
        let operation1 = BlockOperation {
            sleep(1)
            print("OperationSuspensedTest test1")
        }
        
        let operation2 = BlockOperation {
            sleep(1)
            print("OperationSuspensedTest test2")
        }
        
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(operation1)
        operationQueue.addOperation(operation2)
        
        operationQueue.isSuspended = true
        
    }
    
}


// sample isSuspended
//let operationSuspensedTest = OperationSuspensedTest()
//operationSuspensedTest.test()
//
//let operationQueue = OperationQueue()
//
//let operation1 = BlockOperation { print("isSuspended test1") }
//let operation2 = BlockOperation { print("isSuspended test2") }
//
//operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
//
//operationQueue.isSuspended = true

//var operationQueue1: OperationQueue? = OperationQueue()
//let operationQueue2 = OperationQueue()
//
//var int = 1
//let operation = BlockOperation { print(int); int += 1; sleep(1) }
//
//operationQueue1?.addOperation(operation)
//operationQueue1?.isSuspended = true
//operationQueue1 = nil
//operationQueue2.addOperation(operation)

//let operationQueue = OperationQueue()
//let operation = BlockOperation { print("start"); sleep(2); print("end") }
//
//operationQueue.addOperation(operation)
//sleep(1);
//operationQueue.isSuspended = true
