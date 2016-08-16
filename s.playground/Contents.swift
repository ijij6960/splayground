//: Playground - noun: a place where people can play

import UIKit
import AVFoundation



var str = "hotfix"
var result = str
var sum = 0

print (str.startIndex)
print (str[str.startIndex])
print (str[str.endIndex.predecessor()])


var abc = "abcd "

func strTest (str :String) {
//    str.removeAtIndex(str.endIndex.predecessor())
}


let myString = "  \t\t  Let's trim all the whitespace  \n \t  \n  "


//let trimmedString = " abc ".trimming(.whitespceAndnewlines)

/*
func catchEng(atnum :Int) -> String {
    let result = ""
    return result
}

while (!source.isEmpty )
{
    
}*/




// 스트링의 좌우에 \n, 스페이스, TAB 삭제
//let strEngRange = getFirstPosEng(source)..<get
// let strEng = source.remove (getFirstPosEng (source), getLastPosEng (source))
// let strEng = source.subString (getFirstPosEng (source), getLastPosEng (source))



/*

var str = "ABCDE"
var s2 = str
s2.(Range(location:0, length:3)) // "ABC"

print (str)
print (s2)*/


/*
var welcome = "hello"
welcome.insertContentsOf("~~!".characters, at: welcome.endIndex)
welcome.removeAtIndex(welcome.endIndex.predecessor().advancedBy(-3))
welcome.insert("o", atIndex: welcome.startIndex.advancedBy(4))

let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)

print()
print(welcome)


var constantString = "Highlander"
constantString += " and another Highlander"


for index in constantString.characters.indices {
    print("\(constantString[index]) ")
}
 */
