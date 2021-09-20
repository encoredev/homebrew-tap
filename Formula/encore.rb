class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.17.2"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.2-darwin_amd64.tar.gz"
    sha256 "e6470a999c174efc1471c0e5b86fe3b7ab56097f486440765e7a999cfd2d3b57"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.2-darwin_arm64.tar.gz"
    sha256 "30571b4bf031958ca1b1d1cd0b7bed4c91202524271443b3f72c19aa0bb6b4f7"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
