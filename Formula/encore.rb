class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.11.1"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.11.1-darwin_amd64.tar.gz"
    sha256 "e8c359e9d2e6de08f259c7eedc0570ba55a49a91b11b10d0fb155a56db0ec0d3"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.11.1-darwin_arm64.tar.gz"
    sha256 "8d1aabe609e40758262842f80a3aa47c652c5d6d850ca7e8a9d0c3e61ba27c9a"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
