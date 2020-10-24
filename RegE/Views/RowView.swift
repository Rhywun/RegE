//
//  ListRowView.swift
//  RegE
//
//  Created by Patrick Huffer on 2020-08-18.
//

import SwiftUI

struct RowView: View {
    var rule: RegexRule

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(rule.description)
            Text(rule.pattern).foregroundColor(.green).font(.caption)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(rule: ruleData[0])
    }
}
