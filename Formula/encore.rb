class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.14.0"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.0-darwin_amd64.tar.gz"
    sha256 "a1ff0a4e3ef260905cfb767cfc7383c53d45e87278ab78e1d6a8e9d63a9b6307"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.0-darwin_arm64.tar.gz"
    sha256 "699b583ae533e7b44aa20724c152c4e56d6161f04fc7c0f22413d0547f01014d"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
