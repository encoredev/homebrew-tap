class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.10.4"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.4-darwin_amd64.tar.gz"
    sha256 "eecfed6ee7fe174b1343eeff246ed62b49ed1bf02c85c91bbc228ec2bf4cf3e3"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.4-darwin_arm64.tar.gz"
    sha256 "e1172cfc62299c2805b4cf7b5a73a2366f788856b77ffe1a4babbce7162d88ff"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
