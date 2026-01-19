class Copilotguard < Formula
  desc "Lightweight daemon that intercepts and analyzes AI coding assistant traffic"
  homepage "https://github.com/tonycodes/copilotguard-daemon"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-arm64.tar.gz"
      sha256 "a62a74b71de28db4d4e4564999c02bfaec36a9d3bdcd695c241187d3efed1925"
    end
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-amd64.tar.gz"
      sha256 "c26c7bb4cb03290a44d4471f7b79bb25e2bd8739aba6a99677decd409a7a709b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-linux-amd64.tar.gz"
      sha256 "c7ead14056a96579b8264711352e0f3a9184a8b34a6d6c05dc2f014741afcf2c"
    end
  end

  def install
    bin.install "copilotguard"
  end

  def post_install
    ohai "CopilotGuard installed!"
    ohai "Run 'sudo copilotguard install' to complete setup"
  end

  def caveats
    <<~EOS
      To complete installation, run:
        sudo copilotguard install

      This will:
        - Generate a local CA certificate
        - Add the CA to your system trust store
        - Modify /etc/hosts to redirect AI traffic
        - Install and start the system service

      For GitHub Copilot CLI support, add to your shell profile:
        alias copilot='NODE_EXTRA_CA_CERTS=/etc/copilotguard/ca.crt copilot'
    EOS
  end

  test do
    assert_match "copilotguard", shell_output("#{bin}/copilotguard --version")
  end
end
