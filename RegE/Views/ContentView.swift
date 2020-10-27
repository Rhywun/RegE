//
//  ContentView.swift
//  RegE
//
//  Created by Patrick Huffer on 2020-10-24.
//

import SwiftUI
import Guitar
import Introspect

struct ContentView: View {
    @State private var regText: String = ""
    @State private var byRow: Bool = false
    @State private var inputText: String = "Enter text to search here"
    @State private var outputText: String = "Matches are shown here"
    @State private var showHelp: Bool = false

    var body: some View {
        GeometryReader { geometry in
            HStack {
                HSplitView {
                    // TODO: Add placeholders to texteditors if/when Apple adds support
                    TextEditor(text: $inputText)
                        .font(.system(.title2, design: .monospaced))
                    TextEditor(text: $outputText)
                        .font(.system(.title2, design: .monospaced))
                }
                if showHelp {
                    HelpView().frame(width: 300)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TextField("Enter a regular expression", text: $regText)
                        .frame(minWidth: 300, maxWidth: .infinity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .introspectTextField { textField in
                            textField.becomeFirstResponder()
                        }
                }
                ToolbarItem {
                    Toggle("By Rows", isOn: $byRow)
                        .toggleStyle(CheckboxToggleStyle())
                        .help(Text("Check for each row"))
                }
                ToolbarItem {
                    // TODO: Button should be attached to the right edge - how?
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showHelp.toggle()
                        }
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                    .help(Text("Help on regular expressions"))
                }
            }
        }
        .onChange(of: inputText) { _ in
            showMatches()
        }
        .onChange(of: regText) { _ in
            showMatches()
        }
        .onChange(of: byRow) { _ in
            showMatches()
        }
    }

    // TODO: Move business logic out of view
    fileprivate func showMatches() {
        if byRow {
            showMatchesByRow()
        } else {
            showMatchesComplete()
        }
    }

    // TODO: Move business logic out of view
    fileprivate func showMatchesComplete() {
        outputText = Guitar(pattern: regText).evaluateForStrings(from: inputText).joined(separator: ", ")
    }

    // TODO: Move business logic out of view
    fileprivate func showMatchesByRow() {
        let lines = inputText.split { character in
            character.isNewline
        }
        outputText = lines.map { line in
            Guitar(pattern: regText).evaluateForStrings(from: String(line)).joined(separator: ", ")
        }.joined(separator: "\n")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 300, height: 200)
    }
}
