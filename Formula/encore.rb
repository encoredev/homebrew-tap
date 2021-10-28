class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.17.3"
  license ""

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.3-darwin_amd64.tar.gz"
    sha256 "c97c874a22439f008013b227181bb90e61afd6d0ee93d50fe34f2e08ca894b36"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.3-darwin_arm64.tar.gz"
    sha256 "51ac4ea1a77fc9cd4239539ceb04ca51eebcd3623ad517d00f57100dd65a33c4"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
