class Copilotguard < Formula
  desc "Lightweight daemon that intercepts and analyzes AI coding assistant traffic"
  homepage "https://github.com/tonycodes/copilotguard-daemon"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-arm64.tar.gz"
      sha256 "78fea969a3084d9b3e9c6526b1e27a16a31e7c4eaf8237060400b88fcddb7ba4"
    end
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-amd64.tar.gz"
      sha256 "2f962481eb2b1c5df61c0c108d97c0958005aa0198f6056af7b1c286ea61ec7b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-linux-amd64.tar.gz"
      sha256 "a384c4c2fe0ea181cc79c9da587460c0531dcc41a0559e3fb416da0ced9796c9"
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
