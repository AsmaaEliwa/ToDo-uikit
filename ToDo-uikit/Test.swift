//
//  Test.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 08/06/2024.
//
//
//import Foundation
//protocol Shape{
//    func area()->Int
//}
//class MyOperation:Operation{
//    override func main() {
//        if isCancelled{
//            print("cancelled")
//        }
//    }
//}
//class Test{
//    func test(){
//        let lock = NSLock()
//        let semaphore = DispatchSemaphore(value: 1)
//        let myOperation = MyOperation()
////        myOperation.addDependency(<#T##op: Operation##Operation#>)
//        myOperation.cancel()
//        
//        myOperation.addDependency(<#T##op: Operation##Operation#>)
//        semaphore.wait()
//        lock.lock()
////        do somthing
//        lock.unlock()
//        semaphore.signal()
//        var myBlockOeration = BlockOperation(block: {print("first task")})
//        let cache = NSCache<NSString,AnyObject>()
//        cache.setObject(<#T##obj: AnyObject##AnyObject#>, forKey: <#T##NSString#>) //save data
//        cache.object(forKey: <#T##NSString#>) // get
//    }
//    let userDefault = UserDefaults.standard
//    let array = [1,2]
//    func addData(){
//        userDefault.set(array, forKey: "myArray")
//        userDefault.array(forKey: "myArray")
//    }
//}
////user// autofill
////autolayout constarins
////stackView
//
//
//class SOLID{
//    //S siperation of concept
//    class Acount{
//        var amount:Int = 0
//        func addToBalance(amount:Int){
//            self.amount = amount
//        }
//        func createDepatment(){ // we can not have this it should have one main functionality to do
//            
//        }
//    
//    }
//    
//    //O open closed princaple : openn for extension closed for modifiction
////    protocol shape{
////        func area()
////    }
//    class Circle:Shape{    // open for extendintion closed for modifiction
//        let r:Int
//        var calculatedArea:Int = 0
//        init(r: Int) {
//            self.r = r
//        }
//        
//        func area()->Int {
//            return r * r
//        }
//    }
//    class Rectangle:Shape{
//        let x:Int
//        let y:Int
//        init(x:Int,y:Int){
//            self.x = x
//            self.y = y
//        }
//        func area() -> Int {
//            return x * y
//        }
//    }
//    //L LSP  an instance of a subclass should be rblacable with an instance of a superclass without causing any problem
//    
//// if we have the shape protocol and two diff shaps for example circle and a rectangle and we have a function that return  calculateArea and takes a shape
//     func calculateArea(shape: Shape)->Int{
//        return shape.area()
//     }
//    let circle = Circle(r:3)
//    let rec = Rectangle(x:3,y:2)
//    let cArea =  calculateArea(shape: circle)
//    let rArea =  calculateArea(shape: rec)
//    
//    //i iSP
//    protocol Task {
//        func a()
//        func b()
//        func c()
//        func d()
//    }
//    class A:Task{   // we want this to implement only func a not b c and d
//        func a(){
//            
//        }
//        func b(){}
//        func c(){}
//        func d(){}
//    }
//    
//    //so its better to do so
//    protocol a1 {
//        func a()
//    }
//    protocol b1 {
//        func b()
//    }
//    class A:a1{
//        func a() {
//            // this is a better practice
//        }
//    }
//    
//    // D dependancy invertion prenciple
//    protocol Engine {
//        func start()
//        func stop()
//    }
//    class Car{
//        var engine:Engine
//        init(engine:Engine){
//            self.engine = engine
//        }
//    }
//    func startEngin(){
//        self.engine.start()
//    }
//    
//    
//}
////delegation
//protocol myDelegate{
//    func findData()
//}
//class A{
//    var delegate: myDelegate?
//    
//}
//class B :myDelegate{
//    func findData() {
//        
//    }
//    
//    var a = A()
//    init(){
//        a.delegate = self
//    }
//    
//}
////associated values
//enum Colors{
//    case red (duration: Int)
//    case green (duration: Int)
//}
//let color = Colors.green(duration: 10)
//func printDuration(color:Colors){
//    switch color{
//    case .red(let duration):
//        print(duration)
//    case .green(let duration):
//        print(duration)
//    }
//}
////printDuration(color: Colors.green(duration: 10))
////raw values
//enum fruits:Int{
//    case orange = 1
//    case banana = 2
//    case apple
//}
//let fruit = fruits.apple.rawValue // accessing the raw value 3
////computed property
//struct Circle{
//    var redious: Int
//    var value:  Int{
//        set{
//            redious = newValue
//        }
//        get{
//            return redious * redious
//        }
//    }
//}
////wrapper
//@propertyWrapper
//struct ageRange{
//    var value:Int
//    
//    var wrappedValue: Int? {
//        get{
//            value
//        }
//        set{
//            if newValue ?? 0 > 0 && newValue ?? 0 < 120{
//                value = newValue ?? 0
//            }
//        }
//    }
//}
//class user{
//    @ageRange var age:Int?
//    init(age:Int){
//        self.age = age
//    }
//}
//
//
//class MyClass {
//    var myClosure:(()->Void)
//    func test(){
//        myClosure = {[self]
//            self.doSomthing()
//    }
//        
//     
//    }
//    func doSomthing(){
//        
//    }
//    init(){
//        
//    }
//    
//}
