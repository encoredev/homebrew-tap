class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.1"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.1-darwin_amd64.tar.gz"
    sha256 "dd49bcc1bfcd22782ae206288f4ca7ffe00f13d50c9ade8e00e9416bbaa5360e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.1-darwin_arm64.tar.gz"
    sha256 "94724703982ce3d913b48bec4d36977e1c264cefe861f27778e86098638cd65a"
  end

  depends_on "wireguard-tools" => :recommended
  depends_on "wireguard-go" => :recommended

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
