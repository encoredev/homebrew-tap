class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.9.1"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-darwin_amd64.tar.gz"
    sha256 "9edd36838e0c08ee8a93c61238439a7bad521f6d7e8be03a81d83fac1c54215c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-darwin_arm64.tar.gz"
    sha256 "cc4405e56b768f1bee8ab5a92779754fde4148d89bbc31cb40303a4a5aa93b4e"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-linux_amd64.tar.gz"
    sha256 "df161f28e7ea07285c7de48d35fde58de64464f1e03b07d1fadc0ac41c6ca52a"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-linux_arm64.tar.gz"
    sha256 "859ac30a3da796a4ffc744e5018a73f154c4b8dfea71cb21040d21def0aca001"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]

    # Install bash completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
    (bash_completion/"encore").write output

    # Install zsh completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
    (zsh_completion/"_encore").write output

    # Install fish completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
    (fish_completion/"encore.fish").write output
  end

  test do
    system "#{bin}/encore", "check"
  end
end
