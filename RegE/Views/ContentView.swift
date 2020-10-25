//
//  ContentView.swift
//  RegE
//
//  Created by Patrick Huffer on 2020-10-24.
//

import SwiftUI
import Guitar

struct ContentView: View {
    @State var regText: String = ""
    @State var byRow: Bool = false
    @State var inputText: String = "Enter text to search here"
    @State var outputText: String = "Matches are shown here"
    @State var showHelp: Bool = false

    var body: some View {
        GeometryReader { geometry in
            HStack {
                HSplitView {
                    // TODO: Add placeholders to texteditors if Apple adds support
                    TextEditor(text: $inputText)
                        .font(.system(.title, design: .monospaced))
                        .onChange(of: inputText) {
                            showMatches(for: $0)
                        }
                    TextEditor(text: $outputText)
                        .font(.system(.title, design: .monospaced))
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
                        .onChange(of: regText) {
                            showMatches(for: $0)
                        }
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
                }
            }
        }
    }

    // TODO: Move business logic out of view
    func showMatches(for input: String) {
        outputText = Guitar(pattern: regText).evaluateForStrings(from: input).joined(separator: ",")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 300, height: 200)
    }
}
