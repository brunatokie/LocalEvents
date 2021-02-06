//
//  EventTableViewCell.swift
//  LocalEvents
//
//  Created by Toki on 06/02/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    let eventImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()

    let eventTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(eventImageView)
        containerView.addSubview(eventTitleLabel)
        containerView.addSubview(dateLabel)
        self.contentView.addSubview(containerView)


        eventImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        eventImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant:70).isActive = true

        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.eventImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true

        eventTitleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        eventTitleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true

        dateLabel.topAnchor.constraint(equalTo:self.eventTitleLabel.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo:self.eventTitleLabel.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true


    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

}
    

