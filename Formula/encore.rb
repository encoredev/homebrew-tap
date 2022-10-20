class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.9.0"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.0-darwin_amd64.tar.gz"
    sha256 "0814199e9a8594b6831733fa5c32ce0eb2d82911208f877ccccef2943e733c55"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.0-darwin_arm64.tar.gz"
    sha256 "9b08be71ac6c401cca1a62a589d0b2e08ebdf18bb57af23e71f6b35cd40a59eb"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.0-linux_amd64.tar.gz"
    sha256 "aa9192d3660d611b597df0d3e1e5e095a8afba94ae3d9a624bef99ba385223ae"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.0-linux_arm64.tar.gz"
    sha256 "5d43913fe2b7eecc75863ae1a13366f2f01587a2b891868ae20549a8332f9d57"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]

    # Install bash completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
    (bash_completion/"encore").write output

    # Install zsh completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
    (zsh_completion/"_encore").write output

    # Install fish completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
    (fish_completion/"encore.fish").write output
  end

  test do
    system "#{bin}/encore", "check"
  end
end
