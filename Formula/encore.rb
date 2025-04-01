class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.15"
    checksums = {
        "darwin_arm64" => "573c64410bae709012d7d352419152bae7744d2b957f7f6a58ab23f99f37e11a",
        "darwin_amd64" => "6d0a0e1e7304494c4ab1d204686bdba7a07e9b7e10482e749b9223c1aec11243",
        "linux_arm64"  => "e863303220ed4531d26003ad6378bf67d907ae21e9c2ec39855d451ece33800b",
        "linux_amd64"  => "2b5960650f16ccbaf8dc3a28d2e02d4604e9948a78e0359858851ea55d771871",
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
