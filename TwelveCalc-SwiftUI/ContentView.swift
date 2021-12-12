//
//  ContentView.swift
//  Twelve-ish
//
//  Created by Michael Rockhold on 12/10/21.
//

import SwiftUI

enum Digit: Character {
    case zero = "\u{014C}"   // Ō, LATIN CAPITAL LETTER O WITH MACRON
    case one = "\u{0391}"    // Α, GREEK CAPITAL LETTER ALPHA, Unicode: U+0391, UTF-8: CE 91
    case two = "\u{0392}"    // Β, GREEK CAPITAL LETTER BETA, Unicode: U+0392, UTF-8: CE 92
    case three = "\u{0393}"  // Γ, GREEK CAPITAL LETTER GAMMA, Unicode: U+0393, UTF-8: CE 93
    case four = "\u{0394}"   // Δ, GREEK CAPITAL LETTER DELTA, Unicode: U+0394, UTF-8: CE 94
    case five = "\u{0395}"   // Ε, GREEK CAPITAL LETTER EPSILON, Unicode: U+0395, UTF-8: CE 95
    case six = "\u{03DA}"    // Ϛ, GREEK LETTER STIGMA, Unicode: U+03DA, UTF-8: CF 9A
    case seven = "\u{0396}"  // Ζ, GREEK CAPITAL LETTER ZETA, Unicode: U+0396, UTF-8: CE 96
    case eight = "\u{0397}"  // Η, GREEK CAPITAL LETTER ETA, Unicode: U+0397, UTF-8: CE 97
    case nine = "\u{0398}"   // Θ, GREEK CAPITAL LETTER THETA, Unicode: U+0398, UTF-8: CE 98
    case dek = "\u{03A7}"    // Χ, GREEK CAPITAL LETTER CHI, Unicode: U+03A7, UTF-8: CE A7
    case elf = "\u{03A8}"    // Ψ, GREEK CAPITAL LETTER PSI, Unicode: U+03A8, UTF-8: CE A8
    
    static let digits: [Digit] = [.zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dek, .elf]
    
    
    static func makeDigitArray(_ d: Int) -> [Digit] {
        var dd = [Digit]()
        
        var d1 = d
        repeat {
            let r = d1 % 12
            dd.insert(digits[r], at: 0)
            d1 = d1 / 12
        } while d1 != 0
        
        return dd
    }
    
    func intValue() -> Int {
        let i = Digit.digits.firstIndex(of: self)!
        return Int(i)
    }
}

struct DuodecimalNumber {
    let positive: Bool
    let digits: [Digit]
    
    func toString() -> String {
        var s = positive ? "" : "-"
        for d in digits {
            s.append(d.rawValue)
        }
        return s
    }
}

extension DuodecimalNumber {
    init(_ i: Int) {
        if i < 0 {
            self.init(positive: false, digits: Digit.makeDigitArray(-i))
        } else {
            self.init(positive: true, digits: Digit.makeDigitArray(i))
        }
    }
}

func digitKeycap(k: Digit) -> some View {
    return Text(String(k.rawValue))
        .frame(width: 44, height: 44, alignment: .center)
        .padding()
        .background(Color.red)
        .clipShape(Circle())
        .font(.largeTitle)
        .foregroundColor(.white)
}

func mathOperatorKeycap(name: String) -> some View {
    Image(systemName: name)
        .frame(width: 44, height: 44, alignment: .center)
        .padding()
        .background(Color.blue)
        .clipShape(Circle())
        .font(.largeTitle)
        .foregroundColor(.white)
}

func stackOperatorKeycap(name: String) -> some View {
    Image(systemName: name)
        .frame(width: 44, height: 44, alignment: .center)
        .padding()
        .background(Color.yellow)
        .clipShape(Circle())
        .font(.largeTitle)
        .foregroundColor(.white)
}

func duodecimalStringToInt(_ s: String) -> Int {
    var value = 0
    var startIndex = s.startIndex
    var negativeFactor = 1
    if let c1 = s.first {
        if c1 == "-" {
            negativeFactor = -1
            startIndex = s.index(after: startIndex)
        }
    }
    for c in s[startIndex...] {
        let d = Digit(rawValue: c)!
        value = value * 12 + d.intValue()
    }
    return value * negativeFactor
}

func beep() {
    
}

struct ContentView: View {
    @State var valueStack = [Int]() {
        didSet {
            stackText = duoDecIntString(valueStack)
        }
    }
    @State var currentValue: Int? = nil {
        didSet {
            if currentValue == nil {
                currentValueText = ""
                decimalValueText = ""
            } else {
                currentValueText = DuodecimalNumber(currentValue!).toString()
                decimalValueText = String(currentValue!)
            }
        }
    }
    
    @State var stackText = ""
    @State var currentValueText = ""
    @State var decimalValueText = ""

    func digitButton(_ digit: Digit) -> some View {
        return Button(action: {
            if let value = currentValue {
                currentValue = value * 12 + digit.intValue()
            } else {
                currentValue = digit.intValue()
            }
        })
        { digitKeycap(k: digit) }
    }
    
    func duoDecIntString(_ ii: [Int]) -> String {
        guard !ii.isEmpty else { return "" }
        var ss = ""
        for i in ii {
            if ss.isEmpty {
                ss = "\(DuodecimalNumber(i).toString())"
            } else {
                ss = "\(ss), \(DuodecimalNumber(i).toString())"
            }
        }
        return ss
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing, spacing: 2) {
                Text(stackText)
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: .none, minHeight: 44, idealHeight: 44, maxHeight: .none, alignment: .trailing)
                    .font(.title)
                    
                Text(currentValueText)
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: .none, minHeight: 44, idealHeight: 44, maxHeight: .none, alignment: .trailing)
                    .font(.largeTitle)
            }
            HStack {
                VStack {
                    
                    HStack {
                        digitButton(.zero)
                        digitButton(.one)
                        digitButton(.two)
                    }
                    HStack {
                        digitButton(.three)
                        digitButton(.four)
                        digitButton(.five)
                    }
                    HStack {
                        digitButton(.six)
                        digitButton(.seven)
                        digitButton(.eight)
                    }
                    HStack {
                        digitButton(.nine)
                        digitButton(.dek)
                        digitButton(.elf)
                    }
                    
                    HStack() {
                        Button(action: {
                            currentValue = nil
                            valueStack = [Int]()
                        })
                        { stackOperatorKeycap(name: "clear") }
                        
                        Button(action: { })
                        { stackOperatorKeycap(name: "gear") }
                    }
                }
                VStack {
                    Button(action: {
                        guard let divisor = currentValue else { return }
                        guard divisor != 0 else {
                            beep()
                            return
                        }
                        guard let tos = valueStack.popLast() else { return }

                        currentValue = tos / divisor
                    })
                    { mathOperatorKeycap(name: "divide") }
                    
                    Button(action: {
                        guard let multipland = currentValue else { return }
                        guard let tos = valueStack.popLast() else { return }

                        currentValue = tos * multipland
                    })
                    { mathOperatorKeycap(name: "multiply") }
                    
                    Button(action: {
                        guard let addand = currentValue else { return }
                        guard let tos = valueStack.popLast() else { return }

                        currentValue = tos - addand
                    })
                    { mathOperatorKeycap(name: "minus") }
                    
                    Button(action: {
                        guard let addand = currentValue else { return }
                        guard let tos = valueStack.popLast() else { return }

                        currentValue = tos + addand
                    })
                    { mathOperatorKeycap(name: "plus") }
                    
                    Button(action: {
                        guard let v = currentValue else { return }
                        valueStack.append(v)
                        currentValue = nil
                    })
                    { stackOperatorKeycap(name: "return") }
                }
            }
            
            Text("Decimal Value: \(decimalValueText)")
                .font(.caption2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
