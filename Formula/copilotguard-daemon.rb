class CopilotguardDaemon < Formula
  desc "Lightweight daemon that intercepts and analyzes AI coding assistant traffic"
  homepage "https://github.com/tonycodes/copilotguard-daemon"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-arm64.tar.gz"
      sha256 "0531e4fa6347fb4ff4831b518a91435b294a1f59feb6dd8ef77154e8ddb476db"
    end
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-amd64.tar.gz"
      sha256 "1a7fb39add2fd56b0dec297c9e8970962b11ca1304b7dfd26abe99dcacf4ba39"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-linux-amd64.tar.gz"
      sha256 "8010ec41f4c21cec52023cc748fbaf271c9899d1ab7e6e30252d2e4bfb8105ba"
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
