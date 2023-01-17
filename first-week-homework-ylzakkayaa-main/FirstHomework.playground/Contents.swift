import Foundation

//ÖDEV1
//Küçük büyük harf duyarlılığı yok
func stringPalindrome (word: String) {
    
    let formattedString = word.replacingOccurrences(of: " ", with: "")
    let characterString = formattedString.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
    let palindromeWord = String(characterString.reversed())
    
    if characterString.uppercased() == palindromeWord.uppercased() {
        print("Girilen \(characterString) palindrome'dur.")
    } else {
        print("Girilen \(characterString) palindrom değildir.")
    }
}

stringPalindrome(word: "Kesti geveze, tez eve gitsek")

//ÖDEV2
extension Array where Element: Hashable {
    func countElements() -> Void {
        var counts = [Element: Int]()
        for element in self {
            counts[element] = (counts[element] ?? 0) + 1
        }
        print(counts)
    }
}
let arrString = ["Ali", "Veli", "Ali", "Ali", "Ali", "Ali", "Veli", "Veli", "Yeliz", "Yeliz"]
arrString.countElements()
let arrInt = [1,2,3,4,1,2,5,3,5,2,2,4]
arrInt.countElements()

//ÖDEV3
func star (number: Int) {
    guard number > 0 else {return}
    var star = String()
    for i in 1...number {
        for _ in 1...i {
            star += "*"
        }
        star += "\n"
    }
    print(star)
}

star(number: 5)


//ÖDEV4
func starPyramid (number: Int) {
    guard number > 0 else {return}
    var star = String()
    for i in 1...number {
        for _ in 1...number+1 - i{
            star += " "
        }
        for _ in 1...i {
            star += "* "
        }
        star += "\n"
    }
    print(star)
}
starPyramid(number: 5)


//ÖDEV5.1
let number = 1000
var sum: Int = 0

for n in 1...number-1 {
    if n % 3 == 0 || n % 5 == 0 {
        sum += n
    }
}

print(sum)

//ÖDEV5.2
var a = 0, b = 1, result = 0, evenSum = 0
  
while result <= 4000000{
    a = b
    b = result
    result = a + b
    if result % 2 == 0{
        evenSum += result
    }
}
print(evenSum)

//ÖDEV5.3
var i = 2
var limit = 600851475143
var primeNumbers = [Int]()

while i <= limit {
    if limit % i == 0 {
        limit /= i
        primeNumbers.append(i)
        i -= 1
    }
    i += 1
}
primeNumbers.sorted()
var largestPrimeNumber = primeNumbers.last
print(largestPrimeNumber!)
