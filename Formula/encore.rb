class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.4"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.4-darwin_amd64.tar.gz"
    sha256 "200453ee303e41b4a5cb7c8447bc8fc557d788eb8cfb756b7991cc36a6b894bf"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.4-darwin_arm64.tar.gz"
    sha256 "919259a5795ce8ac75cd05985c2b39a81570e7aa18e4434d88f5c5c47ea4bfde"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
