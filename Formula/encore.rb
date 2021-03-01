class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.0"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.0-darwin_amd64.tar.gz"
    sha256 "6d866ce7c23bb304a94f0470163acd98860fe8e7e1c428939247650a4734d6c3"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.0-darwin_arm64.tar.gz"
    sha256 "ccf7b356f699c23cec7da5b5e46114e4afcdbe5a71acd82401cdc4db9099f890"
  end

  depends_on "wireguard-tools" => :recommended
  depends_on "wireguard-go" => :recommended

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
