//
//  Test.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 08/06/2024.
//

import Foundation
class MyOperation:Operation{
    override func main() {
        if isCancelled{
            print("cancelled")
        }
    }
}
class Test{
    func test(){
        let lock = NSLock()
        let semaphore = DispatchSemaphore(value: 1)
        let myOperation = MyOperation()
//        myOperation.addDependency(<#T##op: Operation##Operation#>)
        myOperation.cancel()
        semaphore.wait()
        lock.lock()
//        do somthing
        lock.unlock()
        semaphore.signal()
        var myBlockOeration = BlockOperation(block: {print("first task")})
    }
}
