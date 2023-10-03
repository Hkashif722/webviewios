var backgroundTask: UIBackgroundTaskIdentifier = .invalid

func startBackgroundTask() {
    backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
    }
}

func endBackgroundTask() {
    UIApplication.shared.endBackgroundTask(backgroundTask)
    backgroundTask = .invalid
}

func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
    // Delete the cached presentation file after viewing
    if let cachedURL = cachedPresentationURL {
        do {
            try FileManager.default.removeItem(at: cachedURL)
            cachedPresentationURL = nil
        } catch {
            print("Error deleting cached file: \(error)")
        }
    }
    
    // End the background task if it's still running
    endBackgroundTask()
}

