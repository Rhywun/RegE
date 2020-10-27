// swiftlint:disable all

let sentence = "Line 1\r\nLine 2\nLine 3\n"
let lines = sentence.split(whereSeparator: \.isNewline)
print(lines)

let c = Character("a")
c.isNewline
