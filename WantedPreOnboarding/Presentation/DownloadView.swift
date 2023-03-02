//
//  DownloadView.swift
//  WantedPreOnboarding
//
//  Created by dudu on 2023/03/02.
//

import UIKit

final class DownloadView: UIView {
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 20
        
        return stackView
    }()
    
    private let contentImageView: UIImageView = {
        let placeholderImage = UIImage(systemName: "photo")
        let imageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progressViewStyle = .default
        progress.progress = 0.5
        
        return progress
    }()
    
    private let loadButton: UIButton = {
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Load"
        
        return UIButton(configuration: configuration)
    }()
    
    private let id: Int

    init(id: Int) {
        self.id = id + 10
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let width = UIScreen.main.bounds.width

        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(contentImageView)
        contentStackView.addArrangedSubview(progressBar)
        contentStackView.addArrangedSubview(loadButton)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentImageView.widthAnchor.constraint(equalToConstant: width / 3),
            contentImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let loadAction = UIAction { [weak self] _ in
            self?.downloadImage()
        }
        
        loadButton.configurationUpdateHandler = { [weak self] button in
            switch button.state {
            case .highlighted:
                self?.downloadImage()
            case .disabled:
                button.configuration?.showsActivityIndicator = true
                button.configuration?.title = "Loading"
            case .normal:
                button.configuration?.showsActivityIndicator = false
                button.configuration?.title = "Load"
            default:
                break
            }
        }

        loadButton.addAction(loadAction, for: .touchUpInside)
    }
    
    func resetImage() {
        contentImageView.image = UIImage(systemName: "photo")
    }
    
    func downloadImage() {
        loadButton.isEnabled = false
        resetImage()
        
        Task {
            let data = try await ImageDownloader.getImage(with: id)
            self.contentImageView.image = UIImage(data: data)
            self.loadButton.isEnabled = true
        }
    }
}
