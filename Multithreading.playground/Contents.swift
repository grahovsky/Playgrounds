import Foundation


// Multithreading basics

// Pthread unix thread
var thread = pthread_t(bitPattern: 0)
var attr = pthread_attr_t()

pthread_attr_init(&attr)
pthread_create(&thread, &attr, { pointer in
    
    print("Pthread test")

    return nil
    
}, nil)

// Thread obj-c wrapper
var nsthread = Thread(block: {
    print("Thread test")
})
nsthread.start()

// quality of service
@available(iOS 8.0, *)
public enum QualityOfService : Int {
    case userInteractive // animation, ui
    case userInitiated // save doc, click
    case utility // for balance, example load data
    case background // for energy, synchronization, backup
    case `default` // between userInitiated and utility
}

class PthreadQosTest {
    func test() {
        var thread = pthread_t(bitPattern: 0)
        var attribute = pthread_attr_t()
        pthread_attr_init(&attribute)
        pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0)
        pthread_create(&thread, &attribute, { pointer in
            print("PthreadQosTest test")
            pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
            return nil
        }, nil)
    }
}

let pthreadQosTest = PthreadQosTest()
pthreadQosTest.test()

// qos foundation
class QosThreadTest {
    func test() {
        let thread = Thread {
            print("QosThreadTest test")
            print(qos_class_self())
        }
        thread.qualityOfService = .background // change .userInteractive
        thread.start()
        print(qos_class_main()) //.userInteractive
    }
}

let qosThreadTest = QosThreadTest()
qosThreadTest.test()

// synchronization


//pthread_mutex unix realization
class PthreadMutex {
    private var mutex = pthread_mutex_t()
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    func test() {
        pthread_mutex_lock(&mutex) // lock
        //Do something
        pthread_mutex_unlock(&mutex) // unlock
    }
}

let pthreadMutex = PthreadMutex()
pthreadMutex.test()

// NSLockTest, mutex of Foundation
public class NSLockTest {
    private let lock = NSLock()
    func test(i: Int) {
        lock.lock()
        //Do something
        lock.unlock()
    }
}

let nSLockTest = NSLockTest()
nSLockTest.test(i: 1)


// recursiveMutex, unix realization
class RecursiveMutexTest {
    private var mutex = pthread_mutex_t()
    private var attr = pthread_mutexattr_t()
    init() {
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attr)
    }
    func test1() {
        pthread_mutex_lock(&mutex)
        test2()
        pthread_mutex_unlock(&mutex)
    }
    func test2() {
        pthread_mutex_lock(&mutex)
        //Do something
        pthread_mutex_unlock(&mutex)
    }
}

let recursiveMutexTest = RecursiveMutexTest()
recursiveMutexTest.test1()
recursiveMutexTest.test2()


// recursive Foundation
class RecursiveLockTest {
    private let lock = NSRecursiveLock()
    public func test1() {
        lock.lock()
        test2()
        lock.unlock()
    }
    func test2() {
        lock.lock()
        //Do something
        lock.unlock()
    }
}

let recursiveLockTest = RecursiveLockTest()
recursiveLockTest.test1()
recursiveLockTest.test2()

// condition, unix api
class MutexConditionTest {
    private var condition = pthread_cond_t()
    private var mutex = pthread_mutex_t()
    private var attr = pthread_mutexattr_t()
    private var check = false
    init() {
        pthread_cond_init(&condition, nil)
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attr)
    }
    func test1() {
        pthread_mutex_lock(&mutex)
        while !check {
            pthread_cond_wait(&condition, &mutex)
        }
        //Do something
        pthread_mutex_unlock(&mutex)
    }
    func test2() {
        pthread_mutex_lock(&mutex)
        check = true
        pthread_cond_signal(&condition)
        pthread_mutex_unlock(&mutex)
    }
}
let mutexConditionTest = MutexConditionTest()
//mutexConditionTest.test1()
//mutexConditionTest.test2()

//condition Foundation
class ConditionTest {
    private let condition = NSCondition()
    private var check: Bool = false
    func test1() {
        condition.lock()
        while(!check) {
            condition.wait()
        }
        condition.unlock()
    }
    func test2() {
        condition.lock()
        check = true
        condition.signal()
        condition.unlock()
    }
}

let conditionTest = ConditionTest()
//conditionTest.test1()
//conditionTest.test2()


// read write lock, unix only unix
class ReadWriteLockTest {
    private var lock = pthread_rwlock_t()
    private var attr = pthread_rwlockattr_t()
    private var test: Int = 0
    init() {
        pthread_rwlock_init(&lock, &attr)
    }
    var testProperty: Int {
        get {
            pthread_rwlock_rdlock(&lock)
            let tmp = test
            pthread_rwlock_unlock(&lock)
            return tmp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            test = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}

let readWriteLockTest = ReadWriteLockTest()
readWriteLockTest.testProperty = 5
print("\(readWriteLockTest.testProperty)")

// spin lock, fastest lock, not energyeffective
class SpinLockTest {
    private var lock = OS_SPINLOCK_INIT
    func test() {
        //OSSpinLockLock(&lock)
        //Do something ...
        //OSSpinLockUnlock(&lock)
    }
}

// unfair lock
class UnfairLockTest {
    private var lock = os_unfair_lock_s()
    func test() {
        os_unfair_lock_lock(&lock)
        //Do something...
        os_unfair_lock_unlock(&lock)
    }
}


// synchronized
class SynchronizedTest {
    private let lock = NSObject()
    func test() {
        objc_sync_enter(lock)
        //Do something...
        objc_sync_exit(lock)
    }
}

// deadlock
//class DeadLockTest {
//    private let lock1 = NSLock()
//    private let lock2 = NSLock()
//    var resourceA = false
//    var resourceB = false
//
//    let thread1 = Thread(block: {
//        self.lock1.lock()
//        self.resourceA = true
//        self.lock2.lock()
//        self.resourceB = true
//        self.lock2.unlock()
//        self.lock1.unlock()
//    })
//    thread1.start()
//
//    let thread2 = Thread(block: {
//        self.lock2.lock()
//        self.resourceB = true
//        self.lock1.lock()
//        self.resourceA = true
//        self.lock1.lock()
//        self.lock2.lock()
//    })
//    thread2.start()
//
//}

// livelock
class LivelockTest {
    var flag1 = false
    var flag2 = false
    func test() {
        let thread1 = Thread(block: {
            self.flag1 = true
            while self.flag2 {
                self.flag1 = false
                sleep(1) //Delay
                self.flag1 = true
            }
            self.flag1 = true
        })
        thread1.start()
        let thread2 = Thread(block: {
            self.flag2 = true
            while self.flag1 {
                self.flag2 = false
                sleep(1) //Delay
                self.flag2 = true
            }
            self.flag2 = true
        })
        thread2.start()
    }
}

// atomic operation, teory
class AtomicOperationsPseudoCodeTest {
    func compareAndSwap(old: Int, new: Int, value: UnsafeMutablePointer<Int>) -> Bool {
        if(value.pointee == old) {
            value.pointee = new
            return true
        }
        return false
    }
    func atomicAdd(amount: Int, value: UnsafeMutablePointer<Int>) -> Int {
        var success = false
        var new: Int = 0
        while !success {
            let original = value.pointee
            new = original + amount
            success = compareAndSwap(old: original, new: new, value: value)
        }
        return new
    }
}

// exist realization
class AtomicOperationsTest {
    private var i: Int64 = 0
    func test() {
        OSAtomicCompareAndSwap64Barrier(i, 10, &i)
        OSAtomicAdd64Barrier(20, &i)
        OSAtomicIncrement64Barrier(&i)
    }
}

// memory barrier
class MemoryBarrierTest {
    class TestClass {
        var t1: Int?
        var t2: Int?
    }
    var testClass: TestClass?
    
    func test() {
        let thread1 = Thread {
            let tmp = TestClass()
            tmp.t1 = 100
            tmp.t2 = 500
            OSMemoryBarrier()
            self.testClass = tmp
        }
        thread1.start()
        let thread2 = Thread {
            while self.testClass == nil { }
            OSMemoryBarrier()
            print(self.testClass?.t1)
        }
        thread2.start()
    }
}
