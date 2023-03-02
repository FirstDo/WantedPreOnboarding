//
//  MainViewController.swift
//  WantedPreOnboarding
//
//  Created by dudu on 2023/03/02.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let downloadViews = (1...5).map { _ in DownloadView() }
    
    private let downloadAllButton: UIButton = {
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Load All Images"
        
        return UIButton(configuration: configuration)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(contentStackView)
        
        downloadViews.forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.addArrangedSubview(downloadAllButton)
        
        NSLayoutConstraint.activate([
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        
        let downloadAllImageAction = UIAction { _ in
            debugPrint("download all Image")
        }
        
        downloadAllButton.addAction(downloadAllImageAction, for: .touchUpInside)
    }
}
