//
//  WebView.swift
//  TouchMe
//
//  Created by Misha Vrana on 08.05.2023.
//

import SwiftUI
import WebKit

struct WebViewWithNavigation: View {
    @EnvironmentObject var urlManager: URLManager
    @EnvironmentObject var touchGame: TouchGame
    var response: Response
    var status: UserStatus
    
    var body: some View {
        NavigationView {
            WebView(response: response, for: status)
                .navigationBarItems(leading: backButton)
        }
    }
    
    private var backButton: some View {
        Button() {
            withAnimation() {
                touchGame.restartGame()
                urlManager.response = nil
            }
        } label: {
            Image(systemName: "chevron.left")
        }
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    private var response: Response
    
    let webView: WKWebView
    
    init(response: Response, for status: UserStatus) {
        let link = status == .winner ? response.winner : response.loser
        self.response = response
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: link)!))
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
