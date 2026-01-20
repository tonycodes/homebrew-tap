class CopilotguardDaemon < Formula
  desc "Lightweight daemon that intercepts and analyzes AI coding assistant traffic"
  homepage "https://github.com/tonycodes/copilotguard-daemon"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-arm64.tar.gz"
      sha256 "eaf9abc292eeeb279fd154103bde2f4614634906d143ca9d3c22b2e7262d8845"
    end
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-amd64.tar.gz"
      sha256 "5f7062d51aabe5d256020c827d9cca33d9720a05a41f4e4089cb2c0c2c0fe092"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-linux-amd64.tar.gz"
      sha256 "de3821b83b099db40b265406743fcee018f8857a3490317f47771fc1fc2860f3"
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
