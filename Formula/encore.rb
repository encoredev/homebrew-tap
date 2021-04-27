class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.13.2"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.13.2-darwin_amd64.tar.gz"
    sha256 "ae84666c676cf57412e973280712e0ea6b3bb0e4e247c1fc0c2a14d59f02eecf"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.13.2-darwin_arm64.tar.gz"
    sha256 "8868bdda49f8106314efe096cf05a2b3639fce43b8de00469eb5f5c8b0ce02b9"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
