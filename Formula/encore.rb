class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.5"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.5-darwin_amd64.tar.gz"
    sha256 "745bceb33cba07387979c57f5e309c7f2aae1221c957ecb42596554883f4ce8d"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.5-darwin_arm64.tar.gz"
    sha256 "1b3b935589c30143138f4d5f5b1a2aa969999d55f979f4cd626204a62f12edb4"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
