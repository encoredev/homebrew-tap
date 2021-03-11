class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.9"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.9-darwin_amd64.tar.gz"
    sha256 "3c164bf99ed0d59be0d196895102ed962d737542ba23cff70f2d2755417b4db1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.9-darwin_arm64.tar.gz"
    sha256 "43327a54e67fb0ab42fcce480ba1a776c19dfaa35c96a33368ebf5e652a35d0e"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
