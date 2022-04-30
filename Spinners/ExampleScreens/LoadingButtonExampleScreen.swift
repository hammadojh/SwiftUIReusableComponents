//
//  LoadingButton.swift
//  Spinners
//
//  Created by Omar on 30/04/2022.
//

import SwiftUI

struct LoadingButtonExampleScreen: View {
    var body: some View {
        LoadingButton(text: "اضغط هنا", loadingText: "جاري التحميل") {}
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonExampleScreen()
    }
}
