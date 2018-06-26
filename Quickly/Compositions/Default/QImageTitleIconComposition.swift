//
//  Quickly
//

open class QImageTitleIconComposable : QComposable {

    public var image: QImageViewStyleSheet
    public var imageWidth: CGFloat
    public var imageSpacing: CGFloat

    public var title: QLabelStyleSheet

    public var icon: QImageViewStyleSheet
    public var iconWidth: CGFloat
    public var iconSpacing: CGFloat

    public init(
        image: QImageViewStyleSheet,
        title: QLabelStyleSheet,
        icon: QImageViewStyleSheet
    ) {
        self.image = image
        self.imageWidth = 96
        self.imageSpacing = 8
        self.title = title
        self.icon = icon
        self.iconWidth = 16
        self.iconSpacing = 8
        super.init()
    }

}

open class QImageTitleIconComposition< Composable: QImageTitleIconComposable >: QComposition< Composable > {

    public private(set) var imageView: QImageView!
    public private(set) var titleLabel: QLabel!
    public private(set) var iconView: QImageView!

    private var currentEdgeInsets: UIEdgeInsets?
    private var currentImageWidth: CGFloat?
    private var currentImageSpacing: CGFloat?
    private var currentIconWidth: CGFloat?
    private var currentIconSpacing: CGFloat?

    private var selfConstraints: [NSLayoutConstraint] = [] {
        willSet { self.contentView.removeConstraints(self.selfConstraints) }
        didSet { self.contentView.addConstraints(self.selfConstraints) }
    }
    private var imageConstraints: [NSLayoutConstraint] = [] {
        willSet { self.imageView.removeConstraints(self.imageConstraints) }
        didSet { self.imageView.addConstraints(self.imageConstraints) }
    }
    private var iconConstraints: [NSLayoutConstraint] = [] {
        willSet { self.iconView.removeConstraints(self.iconConstraints) }
        didSet { self.iconView.addConstraints(self.iconConstraints) }
    }

    open override class func size(composable: Composable, size: CGSize) -> CGSize {
        let availableWidth = size.width - (composable.edgeInsets.left + composable.edgeInsets.right)
        let imageSize = composable.image.source.size(CGSize(width: composable.imageWidth, height: availableWidth))
        let titleTextSize = composable.title.text.size(width: availableWidth - (composable.imageWidth + composable.imageSpacing + composable.iconWidth + composable.iconSpacing))
        let iconSize = composable.icon.source.size(CGSize(width: composable.iconWidth, height: availableWidth))
        return CGSize(
            width: size.width,
            height: composable.edgeInsets.top + max(imageSize.height, titleTextSize.height, iconSize.height) + composable.edgeInsets.bottom
        )
    }

    open override func setup() {
        super.setup()

        self.imageView = QImageView(frame: self.contentView.bounds)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .horizontal)
        self.imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        self.contentView.addSubview(self.imageView)

        self.titleLabel = QLabel(frame: self.contentView.bounds)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        self.titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        self.contentView.addSubview(self.titleLabel)

        self.iconView = QImageView(frame: self.contentView.bounds)
        self.iconView.translatesAutoresizingMaskIntoConstraints = false
        self.iconView.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
        self.iconView.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .vertical)
        self.contentView.addSubview(self.iconView)
    }

    open override func prepare(composable: Composable, animated: Bool) {
        super.prepare(composable: composable, animated: animated)
        
        if self.currentEdgeInsets != composable.edgeInsets || self.currentImageSpacing != composable.imageSpacing || self.currentIconSpacing != composable.iconSpacing {
            self.currentEdgeInsets = composable.edgeInsets
            self.currentImageSpacing = composable.imageSpacing
            self.currentIconSpacing = composable.iconSpacing

            var selfConstraints: [NSLayoutConstraint] = []
            selfConstraints.append(self.imageView.topLayout == self.contentView.topLayout + composable.edgeInsets.top)
            selfConstraints.append(self.imageView.leadingLayout == self.contentView.leadingLayout + composable.edgeInsets.left)
            selfConstraints.append(self.imageView.trailingLayout == self.titleLabel.leadingLayout - composable.imageSpacing)
            selfConstraints.append(self.imageView.bottomLayout == self.contentView.bottomLayout - composable.edgeInsets.bottom)
            selfConstraints.append(self.titleLabel.topLayout == self.contentView.topLayout + composable.edgeInsets.top)
            selfConstraints.append(self.titleLabel.trailingLayout == self.iconView.leadingLayout - composable.iconSpacing)
            selfConstraints.append(self.titleLabel.bottomLayout == self.contentView.bottomLayout - composable.edgeInsets.bottom)
            selfConstraints.append(self.iconView.topLayout == self.contentView.topLayout + composable.edgeInsets.top)
            selfConstraints.append(self.iconView.leadingLayout == self.titleLabel.trailingLayout + composable.iconSpacing)
            selfConstraints.append(self.iconView.trailingLayout == self.contentView.trailingLayout - composable.edgeInsets.right)
            selfConstraints.append(self.iconView.bottomLayout == self.contentView.bottomLayout - composable.edgeInsets.bottom)
            self.selfConstraints = selfConstraints
        }
        if self.currentImageWidth != composable.imageWidth {
            self.currentImageWidth = composable.imageWidth

            var imageConstraints: [NSLayoutConstraint] = []
            imageConstraints.append(self.imageView.widthLayout == composable.imageWidth)
            self.imageConstraints = imageConstraints
        }
        if self.currentIconWidth != composable.iconWidth {
            self.currentIconWidth = composable.iconWidth

            var iconConstraints: [NSLayoutConstraint] = []
            iconConstraints.append(self.iconView.widthLayout == composable.iconWidth)
            self.iconConstraints = iconConstraints
        }
        composable.image.apply(target: self.imageView)
        composable.title.apply(target: self.titleLabel)
        composable.icon.apply(target: self.iconView)
    }

}
