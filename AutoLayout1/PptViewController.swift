////
////
////import UIKit
////import QuickLook
////
////class PptViewController: UIViewController, QLPreviewControllerDelegate {
////    var previewController: QLPreviewController!
////    var documentInteractionController: UIDocumentInteractionController?
////    var presentationURL: URL?
////    var cachedPresentationURL: URL?
////    let customUTI = "com.kashifhu.AutoLayout1"
////
////    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
////    let overlayView: UIView = {
////        let view = UIView()
////        view.translatesAutoresizingMaskIntoConstraints = false
////        view.backgroundColor = UIColor(white: 0, alpha: 0.5) // Semi-transparent black background
////        view.isHidden = true // Initially hidden
////        return view
////    }()
////
////    let activityIndicator: UIActivityIndicatorView = {
////        let indicator = UIActivityIndicatorView(style: .large)
////        indicator.translatesAutoresizingMaskIntoConstraints = false
////        indicator.color = .gray
////        indicator.hidesWhenStopped = true
////        return indicator
////    }()
////
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = .blue
////
////
////
////        overlayView.addSubview(activityIndicator)
////
////        // Center the activity indicator within the overlay view
////        activityIndicator.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
////        activityIndicator.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
////
////
////        view.addSubview(overlayView)
////        // Constrain the overlay view to cover the entire main view
////        overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
////        overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
////        overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
////        overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
////
////
////
////
////
////
////        // Set up the QLPreviewController
////        previewController = QLPreviewController()
////        previewController.delegate = self
////
////        // Set up the UIDocumentInteractionController
////        documentInteractionController = UIDocumentInteractionController()
////        documentInteractionController?.delegate = self
////
////        // Load the presentation URL
////        presentationURL = URL(string: "https://www.dropbox.com/scl/fi/7ju1z6nvdrs1e9mxso0vm/phy-unit-3.pdf?rlkey=865l3rquoy8cx2xhzalaoy4qm&dl=1")!
////    }
////
////
////    func downloadPresentationIfNeeded(from remoteURL: URL) {
////        showLoader()
////        if let cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
////            let filename = remoteURL.lastPathComponent // Use the last path component of the URL as the filename
////            let localURL = cachesDirectoryURL.appendingPathComponent(filename)
////            // Check if the file already exists in the cache
////            print("local Path: \(FileManager.default.fileExists(atPath: localURL.path))")
////            if FileManager.default.fileExists(atPath: localURL.path) {
////                // The file exists in the cache, so use the cached copy
////                print("File download not needed")
////                cachedPresentationURL = localURL
////                hideLoader()
////                displayPowerPointPresentation()
////
////            } else {
////                // The file doesn't exist in the cache, so download it
////                URLSession.shared.downloadTask(with: remoteURL) { [weak self] (tempLocalURL, _, error) in
////                    DispatchQueue.main.async {
////
////                        if let tempLocalURL = tempLocalURL, error == nil {
////                            // Move the downloaded file to the cache
////                            do {
////                                self!.hideLoader()
////                                print("File download  needed")
////                                try FileManager.default.moveItem(at: tempLocalURL, to: localURL)
////                                self?.cachedPresentationURL = localURL
////                                // Display the downloaded presentation
////                                self?.displayPowerPointPresentation()
////                            } catch {
////                                print("Error moving downloaded file: \(error)")
////                            }
////                        } else {
////                            print("Error downloading file: \(error?.localizedDescription ?? "Unknown error")")
////                        }
////                    }
////                }.resume()
////            }
////        }
////    }
////
////    @IBAction func openPresentationButtonTapped(_ sender: UIButton) {
////        downloadPresentationIfNeeded(from: self.presentationURL!)
////    }
////
////
////
////
////    func displayPowerPointPresentation() {
////        if let pptURL = cachedPresentationURL {
////            // Set the URL for the document interaction controller
////            documentInteractionController?.url = pptURL
////
////
////            // Present the document interaction controller
////            documentInteractionController?.presentPreview(animated: true)
////
////            documentInteractionController?.allowsDocumentAccess = false
////
////        } else {
////            showAlert(message: "Presentation URL is missing")
////        }
////    }
////
////    @IBAction func cleanCacheFile(_ sender: UIButton) {
////        cleanUpCachedFiles()
////    }
////    func cleanUpCachedFiles() {
////        // Check if a cached PPT file exists and delete it
////        if let cachedURL = cachedPresentationURL {
////            print("Cleaning up cached file at URL: \(cachedURL)")
////            do {
////                try FileManager.default.removeItem(at: cachedURL)
////                cachedPresentationURL = nil // Clear the cached file URL
////                print("Cached file deleted successfully.")
////            } catch {
////                print("Error deleting cached file: \(error)")
////            }
////        }
////    }
////
////
////    func showAlert(message: String) {
////        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
////               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
////                   // Delete the cached presentation file after viewing
////                   if let cachedURL = self?.cachedPresentationURL {
////                       do {
////                           try FileManager.default.removeItem(at: cachedURL)
////                           self?.cachedPresentationURL = nil
////                       } catch {
////                           print("Error deleting cached file: \(error)")
////                       }
////                   }
////               }))
////               present(alert, animated: true, completion: nil)
////           }
////}
////
////
////extension PptViewController: UIDocumentInteractionControllerDelegate {
////    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
////        return self
////    }
////
//////    func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
//////            // Delete the cached presentation file after viewin
//////            if let cachedURL = cachedPresentationURL {
//////                do {
//////                    try FileManager.default.removeItem(at: cachedURL)
//////                    cachedPresentationURL = nil
//////                    print("Deleted Exixting ppt")
//////                } catch {
//////                    print("Error deleting cached file: \(error)")
//////                }
//////            }
//////   }
////
//////    func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
//////        if let app = application {
//////            // Check if the document is being sent to another application
//////            if app != "com.apple.mobilenotes" {
//////                // Allow sending to all apps except Notes (for example)
//////                controller.uti = "public.data" // Reset to a public UTI
//////            }
//////        }
//////    }
////}
////
////extension PptViewController: QLPreviewControllerDataSource {
////    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
////        return 1
////    }
////
////    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
////        // Return the PresentationItem
////        return cachedPresentationURL! as QLPreviewItem
////    }
////}
////
////extension PptViewController {
////
////
////    func showLoader() {
////        DispatchQueue.main.async {
////            self.overlayView.isHidden = false
////            self.activityIndicator.startAnimating()
////        }
////    }
////
////    func hideLoader() {
////        DispatchQueue.main.async {
////            self.overlayView.isHidden = true
////            self.activityIndicator.stopAnimating()
////        }
////    }
////
////
////
////
////}
//
//
////

import UIKit
import WebKit

class PptViewController: UIViewController {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a WKWebView
//        webView = WKWebView()
//        webView.navigationDelegate = self
//
//        // Load the PDF file
//
//        // webView.isUserInteractionEnabled = false
//        // webView.scrollView.contentInsetAdjustmentBehavior = .never
//        webView.scrollView.isScrollEnabled = true
//        webView.scrollView.panGestureRecognizer.isEnabled = true
//        webView.scrollView.pinchGestureRecognizer?.isEnabled = true
    }

//    @objc func goBack() {
//        print("check")
//        webView.removeFromSuperview()
//    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        webView.frame = view.bounds
//    }


    @IBAction func clickOpenPpt(_ sender: UIButton) {


//        view.addSubview(webView)
//
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
//        self.navigationItem.leftBarButtonItem = backButton
//        if let url = URL(string: "https://www.dropbox.com/scl/fi/l2amkraauq45017h73ser/It-Act-2000.pptx?rlkey=q7hoxmwn8tcbvzsnu8ngwqm64&dl=1") {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }

        let vc = MsOfficeDocViewController()
        let url1 = "https://www.dropbox.com/scl/fi/l2amkraauq45017h73ser/It-Act-2000.pptx?rlkey=q7hoxmwn8tcbvzsnu8ngwqm64&dl=1"
        let ur2 = "https://www.dropbox.com/scl/fi/qp4iklo38th9sr46glijk/file_example_PPT_1MB.ppt?rlkey=ahbdus0y3uka3a3pgov86qh4v&dl=1"
        let url3 = "https://www.dropbox.com/scl/fi/yd68cw19fbo0pwml0c98q/samplepptx.pptx?rlkey=tyvhiizdx5fcjglmn4440zdl7&dl=1"
        let url4 = "https://www.dropbox.com/scl/fi/4y7kde8oy69sflfcnrbuj/Sample-PPT-File-1000kb.ppt?rlkey=cy5x3b9izeg7qxg0b3vam11tp&dl=1"
        let url5 = "https://www.dropbox.com/scl/fi/rt9ckoofdzn5csr26k20g/Sample-PPT-File-1000kb.pptx?rlkey=wmj4e5sf3urzdjzttnoxaf1yt&dl=1"

        let docURL1 = "https://www.dropbox.com/scl/fi/cr5bkdjgq2rfbhiulw2ew/file-sample_1MB.docx?rlkey=3elc06bib5u1hc8caff4iawhq&dl=1"
        let docURL2 = "https://www.dropbox.com/scl/fi/9f365fu62kmifqkv4yhmy/DWSample3-PPTX.pptx?rlkey=zlprquistqra1eamabw939xvh&dl=1"
        let url = "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiMku_LstiBAxXsbmwGHUhVAwMQFnoECBoQAQ&url=https%3A%2F%2Fwiki.documentfoundation.org%2Fimages%2F4%2F47%2FExtlst-test.pptx&usg=AOvVaw18ClgbIBoBfxQe4g6bvjw0&opi=89978449"
        vc.url = URL(string: url)

//        selft.present(vc, animated: true, completion: nil)
        print(URL(string: url)!.lastPathComponent)
        print(isOfficeFile(filename: URL(string: url)!.lastPathComponent))
        if !isOfficeFile(filename: URL(string: url)!.lastPathComponent){
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//    // Show an activity indicator when the web view starts loading
//    let activityIndicator = UIActivityIndicatorView(style: .large)
//    activityIndicator.center = webView.center
//    activityIndicator.startAnimating()
//    activityIndicator.tag = 100 // Assign a tag to the indicator for later removal
//    view.addSubview(activityIndicator)
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        // Hide the activity indicator when the web view finishes loading
//        if let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView {
//            activityIndicator.removeFromSuperview()
//        }
//    }
}

extension PptViewController {
    func isOfficeFile(filename: String) -> Bool {
        let officeExtensions = [".docx", ".xlsx", ".pptx", ".doc", ".xls", ".ppt"]

        // Get the file's extension (without the dot)
        let fileExtension = (filename as NSString).pathExtension.lowercased()

        print("file extension: \(fileExtension)")
        // Check if the extension is in the list of Office extensions
        return officeExtensions.contains("." + fileExtension)
    }
}


//import UIKit
//
//class PptViewController: UIViewController, UIDocumentInteractionControllerDelegate {
//    var documentController: UIDocumentInteractionController?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Replace this with the URL of your .pptx file
//        guard let pptxURL = URL(string: "https://www.dropbox.com/scl/fi/9nsccqtz0ds81fgdard2r/Free_Test_Data_1MB_PPTX.pptx.ppt?rlkey=jdg666uhgxb39q4jwm8y88qen&dl=1") else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: pptxURL) { (data, response, error) in
//            if let error = error {
//                print("Download error: \(error.localizedDescription)")
//                return
//            }
//
//            if let pptxData = data {
//                // Create a temporary URL to save the data
//                let temporaryURL = FileManager.default.temporaryDirectory.appendingPathComponent("temp.pptx")
//
//                do {
//                    try pptxData.write(to: temporaryURL)
//                } catch {
//                    print("Failed to save file: \(error.localizedDescription)")
//                    return
//                }
//
//                // Initialize the document controller with the temporary URL
//                self.documentController = UIDocumentInteractionController(url: temporaryURL)
//                self.documentController?.delegate = self
//                self.documentController
//
//                // Present the document controller on the main thread
//                DispatchQueue.main.async {
//                    if let controller = self.documentController {
//                        controller.presentPreview(animated: true)
//                    }
//                }
//            }
//        }.resume()
//    }
//
//    // MARK: - UIDocumentInteractionControllerDelegate
//
//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//        return self
//    }
//
//    func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) -> Bool {
//            return false
//        }
//    // Implement other delegate methods as needed
//}
