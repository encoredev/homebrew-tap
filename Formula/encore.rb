class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.14.1"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.1-darwin_amd64.tar.gz"
    sha256 "40f5112aa6910faeebdad8947ad15044c591c7298f051ce815fc8669c74a8b7a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.1-darwin_arm64.tar.gz"
    sha256 "ccce9a0f9b5abc5cdbc7b19d3b0f4190bf960bb4d51f5cbbf9edbf7978ee836d"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
