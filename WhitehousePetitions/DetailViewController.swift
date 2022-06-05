//
//  DetailViewController.swift
//  WhitehousePetitions
//
//  Created by Сергей Цайбель on 03.06.2022.
//

import WebKit
import UIKit

class DetailViewController: UIViewController {
	
	var webView: WKWebView!
	var detailItem: Petition?
	
	override func loadView() {
		webView = WKWebView()
		view = webView
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		guard let detailItem = detailItem else { return }
		
		let html = """
		<html>
		<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<style>
			body { font-size: 150%; }
			h1 { font-weight: bold; }
		</style>
		</head>
		<body>
			<h1> \(detailItem.title) </h1>
			<p> \(detailItem.body) </p>
		</html>
		"""
		
		webView.loadHTMLString(html, baseURL: nil)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
