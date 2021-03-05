class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.2"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.2-darwin_amd64.tar.gz"
    sha256 "9600ceae208463762fd28d17bfced831c360e9aee655c28fa16815078ba22a7e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.2-darwin_arm64.tar.gz"
    sha256 "490a84f6484b1472fd1f29ffc3d1b76a567b06a14b5b1017ab137cb1a386c43a"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
