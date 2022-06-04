//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Сергей Цайбель on 03.06.2022.
//

import UIKit

class ViewController: UITableViewController {
	
	var petitions = [Petition]()
	
	var urlString: String {
		if navigationController?.tabBarItem.tag == 0 {
			return "https://www.hackingwithswift.com/samples/petitions-1.json"
		} else {
			return "https://www.hackingwithswift.com/samples/petitions-2.json"
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Whitehouse Petitions"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))

		do {
			guard let url = URL(string: urlString) else { fatalError() }
			let data = try Data(contentsOf: url)
			parse(json: data)
		} catch {
			let title = "Failed to load petitions!"
			let message = "Check internet connection and try again later."
			showAlert(withTitle: title, and: message)
		}

	}
	
	@objc func showCredits() {
		let ac = UIAlertController(title: "Data came from:", message: urlString, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default)
		ac.addAction(action)
		present(ac, animated: true)
	}
	
	func showAlert(withTitle: String, and message: String) {
		let ac = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default)
		ac.addAction(action)
		present(ac, animated: true)
	}
	
	func parse(json: Data) {
		guard let decoded = try? JSONDecoder().decode(Petitions.self, from: json) else { return }
		petitions = decoded.results
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let petition = petitions[indexPath.row]
		cell.textLabel?.text = petition.title
		cell.detailTextLabel?.text = petition.body
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		let petiton = petitions[indexPath.row]
		vc.detailItem = petiton
		navigationController?.pushViewController(vc, animated: true)
		
	}

}

