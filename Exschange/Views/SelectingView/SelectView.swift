//
//  SelectView.swift
//  Exschange
//
//  Created by Arman Davidoff on 26.10.2020.
//


import UIKit

class SelectView: UIView {
    
    var currencyModels = CurrencyModel.getLocalValues()
    var tableView: UITableView!
    var listButton: CurrencyButton!
    
    weak var delegate: PresentTableViewProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,delegate: PresentTableViewProtocol) {
        self.init(frame: frame)
        self.delegate = delegate
        setupListButton()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure(currencyName: CurrencyModel) {
        listButton.config(currencyName: currencyName.currencyText)
    }
    
    private func setupListButton() {
        backgroundColor = .white
        let frameForButton = CGRect(x: self.frame.width / 2 - ButtonSize.width.rawValue / 2, y: self.frame.height / 2 - ButtonSize.height.rawValue / 2, width: ButtonSize.width.rawValue, height: ButtonSize.height.rawValue)
        
        listButton = CurrencyButton(frame: frameForButton)
        self.addSubview(listButton)
       
        listButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTableView)))
    }
        
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: listButton.frame.origin.x, y: 0, width: listButton.frame.width, height: 0)
        delegate.addToSubview(tableView)
        tableView.isHidden = true
        tableView.layer.cornerRadius = TableViewSizes.cornerRadius.rawValue
        tableView.layer.masksToBounds = true
    }
    
    @objc private func showTableView() {
        tableView.isHidden.toggle()
        tableView.frame.size.height = CGFloat(tableView.numberOfRows(inSection: 0)) * TableViewSizes.rowHeight.rawValue
    }
    
}


//tableViewDelegate&DataSource
extension SelectView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        let model = currencyModels[indexPath.row]
        cell.textLabel?.text = model.currencyText
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewSizes.rowHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = currencyModels[indexPath.row]
        self.configure(currencyName: model)
        delegate.didSelect(currencyModel: model)
        tableView.isHidden = true
    }
}
