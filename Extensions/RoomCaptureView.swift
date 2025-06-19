import SwiftUI
import RoomPlan
import UIKit

// MARK: - SwiftUI View
struct MyRoomCaptureView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingExportSheet = false
    @State private var exportURL: URL?
    
    var body: some View {
            RoomCaptureViewControllerRepresentable()
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showingExportSheet) {
                    if let url = exportURL {
                        ShareSheet(activityItems: [url])
                    }
                }
    }
}

// MARK: - UIViewControllerRepresentable (wrap uikit) 
struct RoomCaptureViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RoomCaptureViewController {
        RoomCaptureViewController()
    }
    
    func updateUIViewController(_ uiViewController: RoomCaptureViewController, context: Context) {}
}

// MARK: - Share Sheet
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - View Controller
class RoomCaptureViewController: UIViewController, RoomCaptureViewDelegate, RoomCaptureSessionDelegate {
    // MARK: - Properties
    private var isScanning: Bool = false
    private var roomCaptureView: RoomCaptureView!
    private var finalResults: CapturedRoom?
    private let roomCaptureSessionConfig = RoomCaptureSession.Configuration()
    
    // MARK: - UI Elements
    private lazy var exportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Export", for: .normal)
        button.addTarget(self, action: #selector(exportResults), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupRoomCaptureView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }
    
    override func viewWillDisappear(_ flag: Bool) {
        super.viewWillDisappear(flag)
        stopSession()
    }
    
    // MARK: - Setup
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelScanning)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneScanning)
        )
    }
    
    private func setupRoomCaptureView() {
        roomCaptureView = RoomCaptureView(frame: view.bounds) 
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
        view.insertSubview(roomCaptureView, at: 0)
    }
    
    private func setupUI() {
        view.addSubview(exportButton)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            exportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exportButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Session Management
    private func startSession() {
        isScanning = true
        roomCaptureView.captureSession.run(configuration: roomCaptureSessionConfig)
        setActiveNavBar()
    }
    
    private func stopSession() {
        isScanning = false
        roomCaptureView.captureSession.stop()
        setCompleteNavBar()
    }
    
    // MARK: - Actions
    @objc private func doneScanning() {
        if isScanning {
            stopSession()
            exportButton.isEnabled = false
            activityIndicator.startAnimating()
        } else {
            cancelScanning()
        }
    }
    
    @objc private func cancelScanning() {
        dismiss(animated: true)
    }
    
    @objc private func exportResults() {
        let destinationFolderURL = FileManager.default.temporaryDirectory.appending(path: "Export")
        let destinationURL = destinationFolderURL.appending(path: "Room.usdz")
        let capturedRoomURL = destinationFolderURL.appending(path: "Room.json")
        
        do {
            try FileManager.default.createDirectory(at: destinationFolderURL, withIntermediateDirectories: true)
            
            if let finalResults = finalResults {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(finalResults)
                try jsonData.write(to: capturedRoomURL)
                try finalResults.export(to: destinationURL, exportOptions: .parametric)
                
                let activityVC = UIActivityViewController(
                    activityItems: [destinationFolderURL],
                    applicationActivities: nil
                )
                
                if let popOver = activityVC.popoverPresentationController {
                    popOver.sourceView = exportButton
                }
                
                present(activityVC, animated: true)
            }
        } catch {
            print("Error = \(error)")
        }
    }
    
    // MARK: - UI Updates
    private func setActiveNavBar() {
        UIView.animate(withDuration: 1.0) {
            self.navigationItem.leftBarButtonItem?.tintColor = .white
            self.navigationItem.rightBarButtonItem?.tintColor = .white
            self.exportButton.alpha = 0.0
        }
    }
    
    private func setCompleteNavBar() {
        exportButton.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBlue
            self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
            self.exportButton.alpha = 1.0
        }
    }
    
    // MARK: - RoomCaptureView Delegate
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        true
    }
    
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResults = processedResult
        exportButton.isEnabled = true
        activityIndicator.stopAnimating()
    }
}
