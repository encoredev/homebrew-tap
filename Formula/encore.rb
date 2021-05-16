class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.14.2"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.2-darwin_amd64.tar.gz"
    sha256 "e98eee8bb4da683ed34cd7ea86ec41d97e2c2bc071408d6cd8c19dbc5f21a866"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.2-darwin_arm64.tar.gz"
    sha256 "0f80f77ba9863e91f0bc046e7e889220dabbd1678f31f021e853212825a0b82b"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
