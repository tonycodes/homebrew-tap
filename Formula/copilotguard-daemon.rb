class CopilotguardDaemon < Formula
  desc "Lightweight daemon that intercepts and analyzes AI coding assistant traffic"
  homepage "https://github.com/tonycodes/copilotguard-daemon"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER_DARWIN_ARM64"
    end
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-amd64.tar.gz"
      sha256 "PLACEHOLDER_DARWIN_AMD64"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-linux-amd64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_AMD64"
    end
  end

  def install
    bin.install "copilotguard-daemon"
  end

  def post_install
    ohai "CopilotGuard Daemon installed!"
    ohai "Run 'sudo copilotguard-daemon install' to complete setup"
  end

  def caveats
    <<~EOS
      To complete installation, run:
        sudo copilotguard-daemon install

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
    assert_match "copilotguard-daemon", shell_output("#{bin}/copilotguard-daemon --version")
  end
end
