class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.16.1"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.1-darwin_amd64.tar.gz"
    sha256 "773f6787dff49d8f9fcea8b3afdc45ec2788798f9de1be5f87a7c73604b4f57a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.1-darwin_arm64.tar.gz"
    sha256 "f2d3e8612fba68ae874390441aaff4882f2fff4f62188135d63eaa98cc5b39cd"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
