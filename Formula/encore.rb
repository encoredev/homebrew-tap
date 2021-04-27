class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.13.4"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.13.4-darwin_amd64.tar.gz"
    sha256 "6ff7602c0bcdd24ece77fb2250125c43d30660045f740c9808ea2b5f2c264070"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.13.4-darwin_arm64.tar.gz"
    sha256 "64073e34c050699ef571fc54bb21cc8d88d9517240db6118ab032d192e4fbd6e"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
