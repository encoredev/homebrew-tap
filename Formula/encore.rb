class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.17.3"
  license ""

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.3-darwin_amd64.tar.gz"
    sha256 "d07a91159c475315ac28d9e182e8ff8e6d50788845bf1f6710adff67a9aa0def"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.3-darwin_arm64.tar.gz"
    sha256 "f56e0d3422fd7e58ede8a482a27584cbb5a5f5522ad5c119eb512339a9f42f0c"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
