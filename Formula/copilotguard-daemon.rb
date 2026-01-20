class CopilotguardDaemon < Formula
  desc "Lightweight daemon that intercepts and analyzes AI coding assistant traffic"
  homepage "https://github.com/tonycodes/copilotguard-daemon"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-arm64.tar.gz"
      sha256 "c3649a559e357e69b3ead4d67af6406621c0e0524380e86047947b9d232b6205"
    end
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-amd64.tar.gz"
      sha256 "023808af9f1b18383e4464f49cb72b67498dbb901dea9f006f5d4ef7db47e489"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-linux-amd64.tar.gz"
      sha256 "9b9e33ab838c01d3064e2246f84f0d77ed1d8729aef1aa529669599239c87274"
    end
  end

  def install
    bin.install "copilotguard-daemon"
  end

  def caveats
    if File.exist?("/etc/copilotguard/ca.crt")
      <<~EOS
        To complete the upgrade, restart the daemon:
          sudo copilotguard-daemon stop
          sudo copilotguard-daemon start
      EOS
    else
      <<~EOS
        First-time setup required. Run:
          sudo copilotguard-daemon install
          copilotguard-daemon login

        This will:
          - Generate a local CA certificate
          - Add the CA to your system trust store
          - Modify /etc/hosts to redirect AI traffic
          - Install and start the system service
          - Connect to your CopilotGuard account

        For GitHub Copilot CLI support, add to your shell profile:
          alias copilot='NODE_EXTRA_CA_CERTS=/etc/copilotguard/ca.crt copilot'
      EOS
    end
  end

  test do
    assert_match "copilotguard-daemon", shell_output("#{bin}/copilotguard-daemon --version")
  end
end
