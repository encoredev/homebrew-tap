class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.10.1"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.1-darwin_amd64.tar.gz"
    sha256 "2b32be70bcd18ffbf4142b428f7b6853fe5ef4773738f6c8604fd4f7c6ece6ae"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.1-darwin_arm64.tar.gz"
    sha256 "766501e37889a938926d32121c1258af7653d78980326115418da9f0a4bebb30"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
