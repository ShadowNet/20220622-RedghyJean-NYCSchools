//
//  SchoolDetailView.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import UIKit
// creating class and object which manages the view hierarchy of the UIKit application
class SchoolDetailView: UIViewController {
    // string value that represents a unique identifier
    var id: String?
    var nameText: String?
    var detail = [ResponseModel]()
    let network = ViewModel()
    // UILabel inherits the UIView class
    private var name: UILabel = {
        let name = UILabel(frame: .zero)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = ""
        name.numberOfLines = 0
        name.textAlignment = .center
        return name
    }()
    
    private var math: UILabel = {
        let name = UILabel(frame: .zero)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Math:      "
        name.numberOfLines = 0
        return name
    }()
    
    private var reading: UILabel = {
        let name = UILabel(frame: .zero)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Reading: "
        name.numberOfLines = 0
        return name
    }()
    
    private var writing: UILabel = {
        let name = UILabel(frame: .zero)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Writing:  "
        name.numberOfLines = 0
        return name
    }()
    // accessing the super class member
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createData()
        setUp()
    }
  
    // This method establishes a strong reference to view
    private func setUp() {
        view.addSubview(name)
        view.addSubview(math)
        view.addSubview(reading)
        view.addSubview(writing)

    // it inherits from the UILayoutGuide class
        let layout = view.safeAreaLayoutGuide
    // activate a set of constraints with one call
        NSLayoutConstraint.activate([
            name.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            name.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),
            name.topAnchor.constraint(equalTo: layout.topAnchor, constant: 20),
    // Returns a constraint that defines one item's attribute
            math.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            math.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),
            math.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -200),
            
            reading.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            reading.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),
            reading.bottomAnchor.constraint(equalTo: math.topAnchor, constant: -20),
            
            writing.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            writing.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),
            writing.bottomAnchor.constraint(equalTo: reading.topAnchor, constant: -20),

        ])
        

        
    }
    // transfer program control out of scope if program conditions are not met
    private func createData() {
        guard let idSearch = id else { return }
        network.loadData = self
        network.createData(urlString: "\(NetworkURL.urlDetails)?dbn=\(idSearch)")
    }

    func setDetails(id: String?, schoolName: String) {
        self.id = id
        name.text = schoolName
    }
    
}

extension SchoolDetailView: NetworkDelegate {

    func dataFinished() {

        reading.text = reading.text?.appending(network.getReadingScore())
        math.text = math.text?.appending(network.getMathScore())
        writing.text = writing.text?.appending(network.getWritingScore())

    }
    // get the value for the "error" key from the error's userInfo dictionary
    func errorOccured(error: Error) {
        self.presentAlert(message: error.localizedDescription)
    }

                          
}

