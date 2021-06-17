class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.15.0"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.15.0-darwin_amd64.tar.gz"
    sha256 "bdbb273840da7f04c4deb90a61cc06e96ec1867c6818aa3e3cbdeb85c39ef9d7"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.15.0-darwin_arm64.tar.gz"
    sha256 "268803f79a0b4c7e35abea891c8f303554561e6a8f9f8e5167c8d33f2e3cb5a5"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
