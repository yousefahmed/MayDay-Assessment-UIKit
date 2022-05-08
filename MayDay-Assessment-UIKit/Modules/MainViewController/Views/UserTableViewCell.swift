//
//  UserTableViewCell.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode        = .scaleAspectFill
        view.backgroundColor    = .gray
        view.clipsToBounds      = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Montserrat.semiBold.of(size: 16)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.01
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = Montserrat.medium.of(size: 10)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.01
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let vStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillProportionally
        view.spacing = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = UserTableViewCell.identifier) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        configureSubviews()
        configureLayoutConstraints()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImageView.image = nil
        self.emailLabel.text = ""
        self.nameLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(vStack)
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(emailLabel)
    }
    
    private func configureLayoutConstraints() {
        configureProfileLayoutConstraints()
        configureVStackLayoutConstraints()
    }
    
    private func configureProfileLayoutConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingGuide = UILayoutGuide()
        contentView.addLayoutGuide(leadingGuide)
        
        NSLayoutConstraint.activate([
            leadingGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 18/414),
            
            profileImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingGuide.trailingAnchor),
        ])
    }
    
    private func configureVStackLayoutConstraints() {
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingGuide = UILayoutGuide()
        contentView.addLayoutGuide(trailingGuide)
        
        NSLayoutConstraint.activate([
            trailingGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trailingGuide.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 18/414),
            
            vStack.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12.0),
            vStack.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor),
        ])
    }
    
    public func configureView(_ user: User) {
        self.nameLabel.text = user.name.fullName
        self.emailLabel.text = user.email
        
        NetworkService.downloadImage(imageURL: user.picture.large, completion: { image, error in
            guard let image = image else {
                return
            }
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
                self.profileImageView.image = image
            }
          
        })
    }
}

#if DEBUG
import SwiftUI
struct UserTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let v = UserTableViewCell()
            return v
        }
        .frame(width: 414, height: 80)
        .previewLayout(.sizeThatFits)
    }
}
#endif


import UIKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI

public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    public let view: View
    public init(_ builder: @escaping () -> View) {
        view = builder()
    }
    // MARK: - UIViewRepresentable
    public func makeUIView(context: Self.Context) -> UIView {
        return view
    }
    public func updateUIView(_ view: UIView, context: Self.Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    public let viewController: ViewController
    
    public init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }
    
    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(context: Self.Context) -> ViewController {
        viewController
    }
    
    @available(iOS 13.0, tvOS 13.0, *)
    @available(OSX, unavailable)
    @available(watchOS, unavailable)
    public func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {
        return
    }
}
#endif

