class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.16.3"
    checksums = {
        "darwin_arm64" => "98984d798618f1de8e4c2590ac9c027382973b65dc0da0ca1a527bd70e31d9c7",
        "darwin_amd64" => "04742e8083912a1322655cea0d3ff981dd3e8096c747a52e8b309197b5422fd4",
        "linux_arm64"  => "d4172c7585841da0310ba5334db25535333d4ace19ed641829b5756f63844668",
        "linux_amd64"  => "e9dd6d146e53372e23dc66f446d6a0d986836b788e0ce944689f942369de7be7",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

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
