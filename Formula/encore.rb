class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.14.4"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.4-darwin_amd64.tar.gz"
    sha256 "6e14c74d739fbfc72bafdcf3d26b8f167482bbe00624edfb316e23ed40525adb"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.4-darwin_arm64.tar.gz"
    sha256 "4e4858ea710075780d3ed2b90d83a796f7a21fa9484b2868ad6ac944821f5332"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
