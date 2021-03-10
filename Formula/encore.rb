class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.7"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.7-darwin_amd64.tar.gz"
    sha256 "0d557f60cf2d0788b8824a11430f48eb6db7b3c1184cb79dc3f0660f4f751d53"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.7-darwin_arm64.tar.gz"
    sha256 "a91c80fa05ec033da2b0878751c5425c0495e4eaa539f45f83fc3b209bf50745"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
