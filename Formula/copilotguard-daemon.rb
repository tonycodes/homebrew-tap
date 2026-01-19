class CopilotguardDaemon < Formula
  desc "Lightweight daemon that intercepts and analyzes AI coding assistant traffic"
  homepage "https://github.com/tonycodes/copilotguard-daemon"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-arm64.tar.gz"
      sha256 "49577d745634ef408c763c890df6909f8da5143b5fdfbbff52c668998f37540a"
    end
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-darwin-amd64.tar.gz"
      sha256 "f344f7dd67c37844a417164cb9162c0aa55da18bc8d744bfe4506ec883275baf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tonycodes/copilotguard-daemon/releases/download/v#{version}/copilotguard-linux-amd64.tar.gz"
      sha256 "fb846f0c69fb7c33257e101926c7dc1a2d10b2de351b728f99980f6ce25d270b"
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
