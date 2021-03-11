class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.8"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.8-darwin_amd64.tar.gz"
    sha256 "1ab349aa6b2b87422d9bd747935a266f0ac9460efeb35cbd613e08504d34ee80"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.8-darwin_arm64.tar.gz"
    sha256 "4e7a1bdc67865d248286077c3ec2a6fa16971ac8f9e02d70dda08fca45e031bb"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
