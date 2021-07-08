class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.16.2"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.2-darwin_amd64.tar.gz"
    sha256 "8684c0dc150c5b7eca3c45e223db5b2ed7862db7c32d25f50a47770a21cff0e1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.2-darwin_arm64.tar.gz"
    sha256 "dfdb0f5a0e644147837b427265528c941e1e46dabc15808a0c4540cf4d25caab"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
