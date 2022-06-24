//
//  ViewController.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import UIKit
//this will create a class named ViewController which is a subclass of UIViewController and will be used to create a view controller
class ViewController: UIViewController {
    //create a variable called network which is of type ViewModel and will be used to create a view model and will be used to create a network connection
    let network = ViewModel()
    //create a variable called tableOfSchools which is of type UITableView and will be used to create a table view
    private lazy var tableOfSchools: UITableView = {
        //create a variable called table and assign it to a UITableView and assign it to a frame of zero initially
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SchoolTitleCell.self, forCellReuseIdentifier: SchoolTitleCell.id)
        table.dataSource = self //set the data source of the table to self to use the
        table.delegate = self //set the delegate of the table to self to use the methods
        return table
    }()

    override func viewDidLoad() { // creating view controller
        super.viewDidLoad() //call the super class's viewDidLoad method to use the methods in the super class
        view.backgroundColor = .white
        setUp()
        network.createData()
        network.loadData = self

    }

    private func setUp() {
        view.addSubview(tableOfSchools)

        tableOfSchools.rowHeight = 70

        let layout = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableOfSchools.leftAnchor.constraint(equalTo: layout.leftAnchor),
            tableOfSchools.rightAnchor.constraint(equalTo: layout.rightAnchor),
            tableOfSchools.topAnchor.constraint(equalTo: layout.topAnchor),
            tableOfSchools.bottomAnchor.constraint(equalTo: layout.bottomAnchor),
        ])
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTitleCell.id, for: indexPath) as? SchoolTitleCell else { return SchoolTitleCell() }
        cell.titleCell.text = network.getName(indexPath.row)
        return cell
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = network.getID(indexPath.row) else { return } //creates a guard statement to check if the id is not nil and if it is then assign it to the id variable and if it is not then return nothing
        guard let schoolName = network.getName(indexPath.row) else { return } //create a guard statement to check if the school name is not nil and if it is then assign it to the schoolName variable and if it is not then return nothing

        let detailView = SchoolDetailView()
        detailView.setDetails(id: id, schoolName: schoolName)
        present(detailView, animated: true)
    }
}

extension ViewController: NetworkDelegate {

    func dataFinished() {
        tableOfSchools.reloadData()

    }

    func errorOccured(error: Error) {
        self.presentAlert(message: error.localizedDescription)
    }

}



extension UIViewController {

    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Hmm Something isn't right.", message: message, preferredStyle: .alert) //this creates a variable called alert and assign it to a UIAlertController and assign it to the title, message and preferred style of alert
        
        //This creates a variable called action and assign it to a UIAlertAction and assign it to the title and style of alert
        let action = UIAlertAction(title: "Affirmative", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }

}


