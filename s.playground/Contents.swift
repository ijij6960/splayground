//: Playground - noun: a place where people can play

import UIKit
import AVFoundation





class Abc
{
    var text = "ABC"
    var wordtype = 0
    
    init (_ text : String)
    {
        self.text = text
    }
}


var array = [Abc]()
var a = Abc("hi")
var b = Abc("hi2")
var c = Abc("hi3")
//c.wordtype = -1

array.append(a)
array.append(b)
array.append(c)

for idx in array.indices.reverse(){
    if array[idx].wordtype != -1 {
        array.insert(Abc("hi_new"), atIndex: idx.successor())
        break
    }
    
}
array

    



var result = ""

print (result)

class EngKorFinder
{
    var source = String()
    var engKorList = Dictionary <String,String>()
    var history = String()
    
    
    func IsEng(ch :Character) ->Bool{
        if (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z") {
            return true
        }
        
        return false
    }
    func IsKor(ch :Character) ->Bool{
        if (ch >= "가" && ch <= "힑"){
            return true
        }
        
        return false
    }
    
    // 영어가 나올때까지 지우면서 찾기
    func SeekFirstEngFromSource() -> Bool {
        
        // 알파벳 A~Z, a~z까지 나올때까지
        for ch in source.characters {
            if (IsEng(ch)) {
                return true
            }
            else {
                history.append(source.characters[source.startIndex])
                source.removeAtIndex(source.startIndex)
            }
        }
        
        return false   // 찾지 못했음
    }
    
    // 한글이 나올때까지 지우면서 찾기
    func SeekFirstKorFromSource() -> Bool {
        
        // 한글 나올때까지
        for ch in source.characters {
            if IsEng(ch) {
                return false
            }
            else if (IsKor(ch))
            {
                return true
            }
            else {
                history.append(source.characters[source.startIndex])
                source.removeAtIndex(source.startIndex)
            }
        }
        
        return false   // 찾지 못했음
    }
    
    // 마지막 글자와 붙어있는 문자 되살리기
    func RestoreLinkedText() -> String
    {
        var result = ""
        
        if history.isEmpty {
            return ""
        }
        
        for idx in history.characters.indices.reverse()
        {
            let ch = history.characters[idx]
            
            if ch == " "
                || ch == "\n"
                || ch == "\t"
            {
                break;
            }
            
            //if (IsKor(ch) == false) {
                result.insert(ch, atIndex: result.startIndex)
            //}
        }
        
        return result
    }

    
    func GatherEngFromSource() -> String {
        var idx = source.startIndex
        var result = source
        
        for ch in source.characters {
            if IsKor(ch) || ch=="\n"
            {
                break;
            }
            else{
                idx = idx.successor()
            }
        }
        
        result.removeRange(idx..<source.endIndex)
        source.removeRange(source.startIndex..<idx)
        history.appendContentsOf(result)
        return result
    }
    
    func GatherKorFromSource() -> String {
        
        // 다음 한글전까지 문자열을 제거하여 result에 넣고
        var idx = source.startIndex
        var result = source
        
        for ch in source.characters {
            if IsEng(ch) || ch=="\n"
            {
                break;
            }
            else{
                idx = idx.successor()
            }
        }
        
        result.removeRange(idx..<source.endIndex)
        source.removeRange(source.startIndex..<idx)
        history.appendContentsOf(result)
        return result
    }
    
    // 완성된 문장의 제일 뒷부분의 공백, "." "," "\n" "\t" 지우기, 
    // 물론 !, ?는 살림
    func CleanLastJunk(str:String) -> String {
        
        var result = str
        for idx in (result.startIndex..<result.endIndex).reverse() {
            if result.hasSuffix(" ")
                || result.hasSuffix(",")
                || result.hasSuffix(".")
                || result.hasSuffix("\n")
                || result.hasSuffix("\t")
                || result.hasSuffix("(")
                || result.hasSuffix("\"")
            {
                //history.append(source.characters[source.startIndex])
                result.removeAtIndex(idx)
            }
            else {
                break
            }
        }
        
        return result
    }
    
    
    // 2차 함수 ------------------------------------
    
    func IsEngKorModeFromSource() -> Int
    {
        for ch in source.characters
        {
            if IsEng(ch){
                return 1
            }
            if IsKor(ch){
                return 2
            }
        }
        return 0
    }
    
    // 다음 한글이나 엔터가 나올때까지 긁어 모으기
    func GetEngFromSource() -> String {
        
        // 영어가 안나오면 ""를 리턴
        if SeekFirstEngFromSource()==false {
            return ""
        }
        
        var result = ""
        result = RestoreLinkedText()
        result += GatherEngFromSource()
        result = CleanLastJunk(result)
        
        return result
    }
    
    func GetKorFromSource() -> String {
        
        if SeekFirstKorFromSource()==false {
            return ""
        }
        
        var result = ""
        result = RestoreLinkedText()
        result += GatherKorFromSource()
        result = CleanLastJunk(result)
        
        return result
    }
    
    
    // 최종처리
    init(_ src :String)
    {
        source = src
        
        while (true)
        {
            // Search Mode 추가 예정
            // if (IsEngKorMode() == true){}
            // else {}
            
            var eng = ""
            var kor = ""

            switch IsEngKorModeFromSource()
            {
            case 1 :
                eng = GetEngFromSource()
                kor = GetKorFromSource()
            case 2 :
                kor = GetKorFromSource()
                eng = GetEngFromSource()
            default:
                return;
            }
            
            if (eng.isEmpty == false && kor.isEmpty == false){
                engKorList.updateValue(kor, forKey: eng)
            }
        }
        
    }
}

//----------------- 현재 진행중 ----------------------------------





//var ekFinder = EngKorFinder("\nhello 안녕\napple. 사과\n Love   사랑\n   . go   ")

var ekFinder = EngKorFinder("(목까지 손으로 대어 보이면서)폭발 일보직전이다 (여기까지 찼어)   (hi)Up to here. ")
print (ekFinder.engKorList)

for dic in ekFinder.engKorList
{
    print(dic.0 + " : " + dic.1)
}

//print (dic.0 + " : " + dic.1)

    



/*
var str = "abc"
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
*/
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
