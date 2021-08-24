class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.16.3"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.3-darwin_amd64.tar.gz"
    sha256 "4c7e6663c7493836a023cb71defb5f98d8bc2642f79fecaabb73c0982c62ca1d"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.3-darwin_arm64.tar.gz"
    sha256 "3d1485550d09723c416890b2d25dfc6b40411f6d780d43e0e1c2260093032b12"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
