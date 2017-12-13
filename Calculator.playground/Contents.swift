//: Playground - noun: a place where people can play

import UIKit

//var input = "1+3-((1-3)+10+(5+9)-2)" // => -16
//var input = "5+16-((9-6+(6-5))-(4-2))" // => 19
//var input = "22+(2-4)" // => 20
//var input = "6+9-12" // => 3
var input = "0-1-1-1-1" // => -4
var stack = [String]()
var operationStack = [String]()
var ops = ["(", ")", "+", "-"]
var inputParsed = [String]()

var cache = ""

func parseInput (val:String) {
    
    for (_, char) in val.enumerated() {
        if ops.contains(String(char)) {
            addCache()
            inputParsed.append(String(char))
            cache = ""
        }
        else {
            cache += String(char)
        }
    }
    addCache()
}

func addCache() {
    if (cache != "") {
        inputParsed.append(cache);
    }
}

func calculate(input:Array<String>) -> Int {
    
    print(inputParsed)
    var sum:Int = 0
    var result:Int = 0
    var lastOp:String = "+"
    
    for i in 0...input.count-1 {
        
        if !ops.contains(input[(i)]) {
            sum = lastOp == "+" ? sum+Int(input[i])! : sum-Int(input[i])!
        }
        else{
            
            if input[i] == "+" || input[i] == "-" {
                lastOp = input[i]
            }
            else if input[i] == "(" {
                
                stack.append(String(sum))
                operationStack.append(lastOp)
                sum = 0
                lastOp = "+"
                print(stack)
                print(operationStack)
                print("-------------")
            }
            else if input[i] == ")" {
                
                if input[i-1] == ")" {
                    
                    let lastObject = stack.removeLast()
                    operationStack.removeLast()
                    
                    stack[stack.count-1] = operationStack[operationStack.count-1] == "+" ? String(Int(lastObject)!+Int(stack[stack.count-1])!) : String(Int(lastObject)!-(Int(stack[stack.count-1])!))
                    sum = 0
                }
                else{
                    stack[stack.count-1] = operationStack.last == "+" ? String(Int(stack.last!)!+sum) : String(Int(stack.last!)!-sum)
                    sum = 0
                }
                
                print(stack)
                print(operationStack)
                print("-------------")
            }
        }
    }
    
    print(stack)
    print(operationStack)
    
    if stack.count > 1 {
        
        for index in stride(from: stack.count-1, to: -1, by: -1) {
            result = operationStack[index] == "+" ? Int(stack[index])! + result : Int(stack[index])! - result
        }
    }
    else if (stack.count > 0){
        result = Int(stack[0])!
    }
    
    return stack.count > 0 ? result : sum;
}

print(input)
parseInput(val: input)
print(calculate(input: inputParsed))
