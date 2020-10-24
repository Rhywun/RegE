//
//  HelpView.swift
//  RegE
//
//  Created by Patrick Huffer on 2020-08-18.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        List(ruleData) { rule in
            RowView(rule: rule)
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView().frame(width: 300, height: 200)
    }
}
