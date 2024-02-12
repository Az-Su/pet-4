//
//  ViewController.swift
//  pet-3
//
//  Created by Sailau Almaz Maratuly on 12.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    var items: [Int] = []
    let identifier = "CustomViewCell"

    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Pet 4"
        
        let button = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(buttonAction))
        navigationItem.rightBarButtonItem = button
        setupSubviews()
        
        items = (1...30).map { $0 }
    }
    
    @objc func buttonAction() {
        items.shuffle()
        
        for (index, _) in items.enumerated() {
            let randomIndex = Int.random(in: 0..<items.count)
            tableView.moveRow(at: IndexPath(row: index, section: 0), to: IndexPath(row: randomIndex, section: 0))
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        cell?.textLabel?.text = "\(items[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let firstIndexPath = IndexPath(row: 0, section: indexPath.section)
        tableView.moveRow(at: indexPath, to: firstIndexPath)
        items.swapAt(0, indexPath.row)
        let cell = tableView.cellForRow(at: firstIndexPath) as? CustomViewCell
        cell?.checkMarkImageView.isHidden.toggle()
    }

}

extension ViewController {
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}








//class TableViewController: UITableViewController {
//
//    var items: [Int] = []
//    let identifier = "Cell"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
//
//        items = (1...30).map { $0 }
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//        cell?.textLabel?.text = "\(items[indexPath.row])"
//        return cell!
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let lastIndexPath = IndexPath(row: 0, section: indexPath.section)
//        tableView.moveRow(at: indexPath, to: lastIndexPath)
//        moveItemToEnd(item: items[indexPath.row])
//    }
//
//    func moveItemToEnd(item: Int){
//        if let index = items.firstIndex(of: item) {
//            items.remove(at: index)
//            items.append(item)
//        }
//    }
//
//}
