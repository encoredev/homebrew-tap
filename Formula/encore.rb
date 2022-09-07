class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.6.1"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.6.1-darwin_amd64.tar.gz"
    sha256 "7f1b71292d908e9873b84ca977d4f4de7f6d6714706175ca2aeb89a87cd3d504"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.6.1-darwin_arm64.tar.gz"
    sha256 "eb3c22da7725a23d41d24d5cac980a8b4dcadffb694c1a7274fe5d2c53ffc42a"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.6.1-linux_amd64.tar.gz"
    sha256 "e53c211ad0aa5dc20d4847324c9ba7494d7f070201481d8e492ef2d4dba62290"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.6.1-linux_arm64.tar.gz"
    sha256 "4ef5296a8a6cb4fb8bbe4920283e6e60e4ada4d5d720abbb36a0d434ef12d1ab"
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
