class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.3"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.3-darwin_amd64.tar.gz"
    sha256 "d88a907a18a713e314eda1a6a06dff9f79967706f14ed70615008ba170c5cef1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.3-darwin_arm64.tar.gz"
    sha256 "80131760ee0204ce6fb302c8c5a3e25f7a94700e3cd75b12d0888192747e4e68"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
